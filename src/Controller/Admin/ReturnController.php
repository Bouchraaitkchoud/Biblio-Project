<?php

namespace App\Controller\Admin;

use App\Entity\Exemplaire;
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
#[IsGranted('ROLE_ADMIN')]
class ReturnController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private ExemplaireRepository $exemplaireRepository,
        private LoggerInterface $logger
    ) {}

    #[Route('/', name: 'admin_returns_index', methods: ['GET'])]
    public function index(): Response
    {
        return $this->render('admin/return/index.html.twig');
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
                    'message' => sprintf('Exemplaire with barcode %s is not currently borrowed (Status: %s)', 
                        $barcode, $exemplaire->getStatus())
                ], 400);
            }

            // Get the cart item for this exemplaire
            $cartItem = $this->entityManager->getRepository('App\Entity\CartItem')
                ->createQueryBuilder('ci')
                ->select('ci', 'c', 'u')
                ->join('ci.cart', 'c')
                ->join('c.user', 'u')
                ->where('ci.exemplaire = :exemplaire')
                ->andWhere('c.status = :status')
                ->setParameter('exemplaire', $exemplaire)
                ->setParameter('status', 'approved')
                ->getQuery()
                ->getOneOrNullResult();

            if (!$cartItem) {
                return new JsonResponse([
                    'success' => false,
                    'message' => 'No approved borrowing record found for this exemplaire'
                ], 404);
            }

            $cart = $cartItem->getCart();

            // Return the response
            return new JsonResponse([
                'success' => true,
                'exemplaire' => [
                    'id' => $exemplaire->getId(),
                    'barcode' => $exemplaire->getBarcode(),
                    'book_title' => $exemplaire->getBook()->getTitle(),
                    'borrowed_by' => $cart->getUser()->getEmail(),
                    'borrowed_date' => $cart->getProcessedAt()->format('Y-m-d')
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

            // Update exemplaire status
            $exemplaire->setStatus('available');
            $exemplaire->setReturnDate(new \DateTime());

            // Update book quantity
            $book = $exemplaire->getBook();
            $currentQuantity = $book->getQuantity();
            $book->setQuantity($currentQuantity + 1);

            $this->entityManager->persist($exemplaire);
            $this->entityManager->persist($book);
            $this->entityManager->flush();

            // Commit transaction
            $this->entityManager->commit();

            return new JsonResponse([
                'success' => true,
                'message' => 'Book returned successfully'
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