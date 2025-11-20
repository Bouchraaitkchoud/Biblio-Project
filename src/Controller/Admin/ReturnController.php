<?php

namespace App\Controller\Admin;

use App\Entity\Exemplaire;
use App\Entity\Order;
use App\Repository\ExemplaireRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Psr\Log\LoggerInterface;

#[Route('/admin/returns')]
#[IsGranted('ROLE_GERER_RETOURS')]
class ReturnController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private ExemplaireRepository $exemplaireRepository,
        private LoggerInterface $logger
    ) {}

    #[Route('/', name: 'admin_returns_index', methods: ['GET'])]
    public function index(EntityManagerInterface $entityManager): Response
    {
        // Retrieve orders that are approved and have not been marked returned
        $pendingOrders = $entityManager->getRepository(Order::class)
            ->createQueryBuilder('o')
            ->leftJoin('o.lecteur', 'l')
            ->leftJoin('o.items', 'oi')
            ->leftJoin('oi.exemplaire', 'e')
            ->leftJoin('e.location', 'loc')
            ->leftJoin('o.processedBy', 'u')
            ->addSelect('l', 'oi', 'e', 'loc', 'u')
            ->where('o.status = :status')
            ->andWhere('o.returnedAt IS NULL')
            ->setParameter('status', 'approved')
            ->getQuery()
            ->getResult();

        return $this->render('admin/return/index.html.twig', [
            'pendingOrders' => $pendingOrders,
        ]);
    }

    #[Route('/scan', name: 'admin_returns_scan', methods: ['POST'])]
    public function scanBarcode(Request $request): JsonResponse
    {
        try {
            $barcode = $request->request->get('barcode');

            if (!$barcode) {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No barcode provided'
                ], 400);
            }

            $barcode = trim($barcode);

            // Log the incoming request
            $this->logger->info('Processing barcode scan request', [
                'barcode' => $barcode
            ]);

            // Find exemplaire using repository
            $exemplaire = $this->exemplaireRepository->findOneByBarcode($barcode);

            if (!$exemplaire) {
                return new JsonResponse([
                    'success' => false,
                    'message' => sprintf('No exemplaire found with barcode: %s', $barcode)
                ], 404);
            }

            // Check if the exemplaire is borrowed
            if ($exemplaire->getStatus() !== 'borrowed') {
                return new JsonResponse([
                    'success' => false,
                    'message' => sprintf(
                        'Exemplaire with barcode %s is not currently borrowed (Status: %s)',
                        $barcode,
                        $exemplaire->getStatus()
                    )
                ], 400);
            }

            // Get the order item for this exemplaire
            $orderItem = $this->entityManager->getRepository('App\Entity\OrderItem')
                ->createQueryBuilder('oi')
                ->select('oi', 'o', 'l', 'e', 'loc')
                ->join('oi.order', 'o')
                ->join('o.lecteur', 'l')
                ->join('oi.exemplaire', 'e')
                ->leftJoin('e.location', 'loc')
                ->where('oi.exemplaire = :exemplaire')
                ->andWhere('o.status = :status')
                ->andWhere('o.returnedAt IS NULL')
                ->setParameter('exemplaire', $exemplaire)
                ->setParameter('status', 'approved')
                ->getQuery()
                ->getOneOrNullResult();

            if (!$orderItem) {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No approved borrowing record found for this exemplaire'
                ], 404);
            }

            $order = $orderItem->getOrder();

            // Return the response
            return new JsonResponse([
                'success' => true,
                'exemplaire' => [
                    'id' => $exemplaire->getId(),
                    'barcode' => $exemplaire->getBarcode(),
                    'book_title' => $exemplaire->getBook()->getTitle(),
                    'borrowed_by' => $order->getLecteur()->getEmail(),
                    'borrowed_date' => $order->getProcessedAt()->format('Y-m-d'),
                    'location' => $exemplaire->getLocation() ? $exemplaire->getLocation()->getName() : 'N/A'
                ]
            ]);
        } catch (\Exception $e) {
            // Log the detailed error
            $this->logger->error('Error in scanBarcode', [
                'error_message' => $e->getMessage(),
                'error_trace' => $e->getTraceAsString(),
                'barcode' => $barcode ?? null
            ]);

            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while processing the barcode. Please try again.'
            ], 500);
        }
    }

    #[Route('/process', name: 'admin_returns_process', methods: ['POST'])]
    public function processReturn(Request $request): JsonResponse
    {
        $exemplaireId = $request->request->get('exemplaire_id');

        if (!$exemplaireId) {
            return new JsonResponse([
                'success' => false,
                'message' => 'No exemplaire ID provided'
            ], 400);
        }

        try {
            // Start transaction
            $this->entityManager->beginTransaction();

            $exemplaire = $this->exemplaireRepository->find($exemplaireId);

            if (!$exemplaire) {
                throw new \Exception('Exemplaire not found');
            }

            if ($exemplaire->getStatus() !== 'borrowed') {
                throw new \Exception('This exemplaire is not currently borrowed');
            }

            // Find the order for this exemplaire
            $orderItem = $this->entityManager->getRepository('App\Entity\OrderItem')
                ->createQueryBuilder('oi')
                ->select('oi', 'o', 'oi2', 'e2')
                ->join('oi.order', 'o')
                ->leftJoin('o.items', 'oi2')
                ->leftJoin('oi2.exemplaire', 'e2')
                ->where('oi.exemplaire = :exemplaire')
                ->andWhere('o.status = :status')
                ->andWhere('o.returnedAt IS NULL')
                ->setParameter('exemplaire', $exemplaire)
                ->setParameter('status', 'approved')
                ->getQuery()
                ->getOneOrNullResult();

            if (!$orderItem) {
                throw new \Exception('No active order found for this exemplaire');
            }

            $order = $orderItem->getOrder();

            // Update exemplaire status
            $exemplaire->setStatus('available');
            $this->entityManager->persist($exemplaire);

            // Check if all items in the order have been returned
            $allReturned = true;
            foreach ($order->getItems() as $item) {
                if ($item->getExemplaire()->getStatus() === 'borrowed') {
                    $allReturned = false;
                    break;
                }
            }

            // If all books returned, mark the order as returned
            if ($allReturned) {
                $order->setReturnedAt(new \DateTime());
                $this->entityManager->persist($order);
            }

            $this->entityManager->flush();

            // Commit transaction
            $this->entityManager->commit();

            return new JsonResponse([
                'success' => true,
                'message' => 'Book returned successfully',
                'exemplaire' => [
                    'id' => $exemplaire->getId(),
                    'barcode' => $exemplaire->getBarcode(),
                    'book_title' => $exemplaire->getBook()->getTitle(),
                ]
            ]);
        } catch (\Exception $e) {
            // Rollback transaction on error
            $this->entityManager->rollback();

            // Log the error
            $this->logger->error('Error processing return', [
                'error_message' => $e->getMessage(),
                'error_trace' => $e->getTraceAsString(),
                'exemplaire_id' => $exemplaireId
            ]);

            return new JsonResponse([
                'success' => false,
                'message' => 'Error processing return: ' . $e->getMessage()
            ], 500);
        }
    }
}
