<?php

namespace App\Controller\Admin;

use App\Entity\Cart;
use App\Entity\Order;
use App\Entity\Exemplaire;
use App\Entity\CartItem;
use App\Service\ReceiptGeneratorService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Psr\Log\LoggerInterface;
use Symfony\Component\Security\Csrf\CsrfTokenManagerInterface;

#[Route('/admin/scan')]
#[IsGranted('ROLE_ADMIN')]
class ScanController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private ReceiptGeneratorService $receiptGenerator,
        private LoggerInterface $logger,
        private CsrfTokenManagerInterface $csrfTokenManager
    ) {}

    #[Route('/', name: 'admin_scan_index', methods: ['GET'])]
    public function index(): Response
    {
        return $this->render('admin/order/scan.html.twig');
    }

    #[Route('/barcode', name: 'admin_scan_barcode', methods: ['POST'])]
    public function scanOrderBarcode(Request $request): JsonResponse
    {
        try {
            // Accept both 'barcode' and 'order_id' parameters (barcode = receipt_code)
            $receiptCode = $request->request->get('barcode') ?? $request->request->get('order_id');
            if (!$receiptCode) {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No receipt code provided'
                ], 400);
            }
            $receiptCode = trim($receiptCode);
            $this->logger->info('Processing order scan request', [
                'receipt_code' => $receiptCode,
                'received_params' => $request->request->all()
            ]);

            // Find order by receipt_code and status pending
            $order = $this->entityManager->getRepository(Order::class)->findOneBy([
                'receiptCode' => $receiptCode,
                'status' => 'pending'
            ]);

            if (!$order) {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No pending order found with this receipt code'
                ], 404);
            }

            // Return order details for approval, including CSRF token
            return new JsonResponse([
                'success' => true,
                'cart_id' => $order->getId(),
                'student' => $order->getLecteur()->getEmail(),
                'request_date' => $order->getPlacedAt()->format('Y-m-d H:i:s'),
                'items' => array_map(function ($item) {
                    return [
                        'book_title' => $item->getExemplaire()->getBook()->getTitle(),
                        'barcode' => $item->getExemplaire()->getBarcode()
                    ];
                }, $order->getItems()->toArray()),
                'csrf_token' => $this->csrfTokenManager->getToken('approve' . $order->getId())->getValue()
            ]);
        } catch (\Exception $e) {
            $this->logger->error('Error in scanOrderBarcode', [
                'error_message' => $e->getMessage(),
                'error_trace' => $e->getTraceAsString(),
                'receipt_code' => $receiptCode ?? null
            ]);
            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while processing the order. Please try again.'
            ], 500);
        }
    }

    #[Route('/exemplaire-barcode', name: 'admin_scan_exemplaire_barcode', methods: ['POST'])]
    public function scanExemplaireBarcode(Request $request): Response
    {
        try {
            $barcode = $request->request->get('barcode');
            if (!$barcode) {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No exemplaire barcode provided'
                ], 400);
            }
            $barcode = trim($barcode);
            $this->logger->info('Processing exemplaire barcode scan request', [
                'barcode' => $barcode
            ]);
            $exemplaire = $this->entityManager->getRepository(Exemplaire::class)
                ->findOneBy(['barcode' => $barcode]);
            if (!$exemplaire) {
                $this->logger->warning('No exemplaire found with barcode', ['barcode' => $barcode]);
                return new JsonResponse([
                    'success' => false,
                    'message' => sprintf('No exemplaire found with barcode: %s', $barcode)
                ], 404);
            }
            $book = $exemplaire->getBook();
            if (!$book) {
                $this->logger->warning('Exemplaire found but associated book is missing', ['exemplaire_id' => $exemplaire->getId(), 'barcode' => $barcode]);
                return new JsonResponse([
                    'success' => false,
                    'message' => 'Associated book not found for this exemplaire.'
                ], 404);
            }
            // Return exemplaire details
            return new JsonResponse([
                'success' => true,
                'exemplaire' => [
                    'id' => $exemplaire->getId(),
                    'barcode' => $exemplaire->getBarcode(),
                    'book_title' => $book->getTitle(),
                    'status' => $exemplaire->getStatus()
                ]
            ]);
        } catch (\Exception $e) {
            $this->logger->error('Error in scanExemplaireBarcode', [
                'error_message' => $e->getMessage(),
                'error_trace' => $e->getTraceAsString(),
                'barcode' => $barcode ?? null
            ]);
            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while processing the exemplaire barcode. Please try again.'
            ], 500);
        }
    }

    #[Route('/approve/{id}', name: 'admin_scan_approve', methods: ['POST'])]
    public function approveScannedCart(int $id, Request $request): Response
    {
        try {
            $order = $this->entityManager->getRepository(Order::class)->find($id);

            // Add debug logging
            $this->logger->info('Approve attempt', [
                'order_id' => $id,
                'order_found' => $order ? 'yes' : 'no',
                'order_status' => $order ? $order->getStatus() : 'n/a'
            ]);

            if (!$order || $order->getStatus() !== 'pending') {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'Invalid order for approval'
                ], 400);
            }

            // Start transaction
            $this->entityManager->beginTransaction();

            // Update exemplaire statuses
            foreach ($order->getItems() as $item) {
                $exemplaire = $item->getExemplaire();

                // Update exemplaire status from reserved to borrowed
                $exemplaire->setStatus('borrowed');
                $this->entityManager->persist($exemplaire);
            }

            // Update order with approval info
            $order->setStatus('approved');
            $order->setProcessedBy($this->getUser());
            $order->setProcessedAt(new \DateTime());

            $this->entityManager->persist($order);
            $this->entityManager->flush();

            // Commit transaction
            $this->entityManager->commit();

            // Generate approval receipt PDF and save temporarily
            $pdfContent = $this->receiptGenerator->generateApprovalReceipt($order);

            $publicDir = $this->getParameter('kernel.project_dir') . '/public/temp';
            if (!is_dir($publicDir)) {
                mkdir($publicDir, 0777, true);
            }

            $filename = 'approval_' . $order->getId() . '_' . time() . '.pdf';
            $filepath = $publicDir . '/' . $filename;
            file_put_contents($filepath, $pdfContent);

            return $this->json([
                'success' => true,
                'message' => 'Order approved successfully.',
                'order_id' => $order->getId(),
                'receipt_url' => '/temp/' . $filename
            ]);
        } catch (\Exception $e) {
            // Rollback transaction on error
            $this->entityManager->rollback();

            // Log the error
            $this->logger->error('Error in approveScannedCart', [
                'error_message' => $e->getMessage(),
                'error_trace' => $e->getTraceAsString(),
                'order_id' => $id
            ]);

            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while approving the order: ' . $e->getMessage()
            ], 500);
        }
    }
}
