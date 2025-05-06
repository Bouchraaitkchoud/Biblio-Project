<?php

namespace App\Controller\Admin;

use App\Entity\Cart;
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
    public function scanOrderBarcode(Request $request): Response
    {
        try {
            $orderId = $request->request->get('barcode'); // This is the order/cart ID from the receipt
            if (!$orderId) {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No order ID provided'
                ], 400);
            }
            $orderId = trim($orderId);
            $this->logger->info('Processing order scan request', [
                'order_id' => $orderId
            ]);
            // Find cart by ID and status pending
            $cart = $this->entityManager->getRepository(Cart::class)->find($orderId);
            if (!$cart || $cart->getStatus() !== 'pending') {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No pending order found with this ID'
                ], 404);
            }
            // Return cart details for approval, including CSRF token
            return new JsonResponse([
                'success' => true,
                'cart_id' => $cart->getId(),
                'student' => $cart->getUser()->getEmail(),
                'request_date' => $cart->getCreatedAt()->format('Y-m-d H:i:s'),
                'items' => array_map(function($item) {
                    return [
                        'book_title' => $item->getExemplaire()->getBook()->getTitle(),
                        'barcode' => $item->getExemplaire()->getBarcode()
                    ];
                }, $cart->getItems()->toArray()),
                'csrf_token' => $this->csrfTokenManager->getToken('approve' . $cart->getId())->getValue()
            ]);
        } catch (\Exception $e) {
            $this->logger->error('Error in scanOrderBarcode', [
                'error_message' => $e->getMessage(),
                'error_trace' => $e->getTraceAsString(),
                'order_id' => $orderId ?? null
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
                $this->logger->error('Exemplaire found but associated book is missing', ['exemplaire_id' => $exemplaire->getId()]);
                return new JsonResponse([
                    'success' => false,
                    'message' => 'Associated book not found for this exemplaire.'
                ], 500);
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
            $cart = $this->entityManager->getRepository(Cart::class)->find($id);
            
            if (!$cart || $cart->getStatus() !== 'pending') {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'Invalid cart for approval'
                ], 400);
            }

            // Start transaction
            $this->entityManager->beginTransaction();

            // Update exemplaire statuses
            foreach ($cart->getItems() as $item) {
                $exemplaire = $item->getExemplaire();
                $book = $exemplaire->getBook();
                
                // Update exemplaire status
                $exemplaire->setStatus('borrowed');
                $this->entityManager->persist($exemplaire);
                
                // Update book quantity
                $currentQuantity = $book->getQuantity();
                if ($currentQuantity > 0) {
                    $book->setQuantity($currentQuantity - 1);
                    $this->entityManager->persist($book);
                }
            }

            // Update cart with approval info
            $cart->setStatus('approved');
            $cart->setProcessedBy($this->getUser());
            $cart->setProcessedAt(new \DateTime());
            
            $this->entityManager->flush();

            // Generate approval receipt
            $pdfContent = $this->receiptGenerator->generateApprovalReceipt($cart);

            // Commit transaction
            $this->entityManager->commit();

            // Return PDF
            return new Response($pdfContent, 200, [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'attachment; filename="approval_receipt.pdf"'
            ]);

        } catch (\Exception $e) {
            // Rollback transaction on error
            $this->entityManager->rollback();
            
            // Log the error
            $this->logger->error('Error in approveScannedCart', [
                'error_message' => $e->getMessage(),
                'error_trace' => $e->getTraceAsString(),
                'cart_id' => $id
            ]);
            
            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while approving the cart'
            ], 500);
        }
    }
} 