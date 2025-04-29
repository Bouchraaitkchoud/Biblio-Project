<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Security;
use App\Entity\Book;
use App\Entity\Cart;
use App\Entity\User;
use App\Entity\Receipt;
use App\Service\CartService;
use Doctrine\ORM\EntityManagerInterface;
use Psr\Log\LoggerInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use App\Service\ReceiptGeneratorService;

class CartController extends AbstractController
{
    private LoggerInterface $logger;
    private CartService $cartService;
    private ReceiptGeneratorService $receiptGenerator;

    public function __construct(
        LoggerInterface $logger, 
        CartService $cartService,
        ReceiptGeneratorService $receiptGenerator
    ) {
        $this->logger = $logger;
        $this->cartService = $cartService;
        $this->receiptGenerator = $receiptGenerator;
    }

    #[Route('/add-to-cart/{id}', name: 'add_to_cart', methods: ['POST'])]
    public function addToCart(int $id, EntityManagerInterface $entityManager, Security $security): Response
    {
        try {
            // 1. Fetch the book
            $book = $entityManager->getRepository(Book::class)->find($id);
            if (!$book) {
                $this->logger->error('Book not found with ID: {id}', ['id' => $id]);
                return new JsonResponse(['success' => false, 'message' => 'Book not found'], 404);
            }

            // 2. Get authenticated user
            /** @var User $user */
            $user = $security->getUser();
            if (!$user) {
                return new JsonResponse(['success' => false, 'message' => 'Authentication required'], 401);
            }

            try {
                // Add book to cookie cart
                $cookie = $this->cartService->addBookToDraftCart($book);
                
                $response = new JsonResponse([
                    'success' => true,
                    'message' => 'Book added to cart'
                ]);
                
                $response->headers->setCookie($cookie);
                
                $this->logger->info('Book {bookId} added to draft cart', [
                    'bookId' => $book->getId()
                ]);
                    
                return $response;
            } catch (\Exception $e) {
                return new JsonResponse([
                    'success' => false,
                    'message' => $e->getMessage()
                ], 400);
            }

        } catch (\Exception $e) {
            $this->logger->error('Cart addition failed: {error}', [
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred'
            ], 500);
        }
    }

    #[Route('/submit-cart', name: 'submit_cart', methods: ['POST'])]
    public function submitCart(EntityManagerInterface $em, Security $security): Response
    {
        /** @var User $user */
        $user = $security->getUser();
        
        if (!$user) {
            return new JsonResponse(['success' => false, 'message' => 'Authentication required'], 401);
        }
        
        try {
            // Convert cookie cart to database entity
            $cart = $this->cartService->convertCookieCartToEntity($user);
            
            if (!$cart) {
                return new JsonResponse(['success' => false, 'message' => 'No cart items found']);
            }

            try {
                // Generate request receipt
                $pdfContent = $this->receiptGenerator->generateRequestReceipt($cart);
                
                // Clear the cookie cart
                $response = new Response($pdfContent, 200, [
                    'Content-Type' => 'application/pdf',
                    'Content-Disposition' => 'attachment; filename="request_receipt.pdf"'
                ]);
                
                $response->headers->setCookie($this->cartService->clearDraftCart());
                
                return $response;
            } catch (\Exception $e) {
                $this->logger->error('Error generating PDF receipt: ' . $e->getMessage(), [
                    'exception' => $e,
                    'cart_id' => $cart->getId(),
                    'user_id' => $user->getId()
                ]);
                
                return new JsonResponse([
                    'success' => false,
                    'message' => 'Failed to generate receipt. Please try again.'
                ], 500);
            }
        } catch (\Exception $e) {
            $this->logger->error('Error submitting cart: ' . $e->getMessage(), [
                'exception' => $e,
                'user_id' => $user->getId()
            ]);
            
            return new JsonResponse([
                'success' => false,
                'message' => $e->getMessage()
            ], 400);
        }
    }

    #[Route('/admin/approve-cart/{id}', name: 'approve_cart', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function approveCart(int $id, EntityManagerInterface $em, Request $request)
    {
        $cart = $em->getRepository(Cart::class)->find($id);
        
        if (!$cart || $cart->getStatus() !== 'pending') {
            return new JsonResponse(['success' => false, 'message' => 'Invalid cart for approval']);
        }

        // Verify CSRF token if coming from web form
        if ($request->isMethod('POST') && !$this->isCsrfTokenValid('approve'.$cart->getId(), $request->request->get('_token'))) {
            return new JsonResponse(['success' => false, 'message' => 'Invalid CSRF token']);
        }

        try {
            // Start transaction
            $em->beginTransaction();

            // Update exemplaire statuses
            foreach ($cart->getItems() as $item) {
                $exemplaire = $item->getExemplaire();
                $exemplaire->setStatus('borrowed');
                $em->persist($exemplaire);
            }

            // Generate receipt
            $receipt = new Receipt();
            $receipt->setCart($cart);
            $receipt->setCode('RCPT-' . date('Ymd') . '-' . strtoupper(uniqid()));
            $receipt->setGeneratedAt(new \DateTime());
            
            // Update cart with approval info
            $cart->setStatus('approved');
            $cart->setProcessedBy($this->getUser());
            $cart->setProcessedAt(new \DateTime());
            
            $em->persist($receipt);
            $em->flush();

            // Commit transaction
            $em->commit();

            return $this->redirectToRoute('receipt_show', ['id' => $receipt->getId()]);
        } catch (\Exception $e) {
            // Rollback transaction on error
            $em->rollback();
            
            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while approving the cart'
            ], 500);
        }
    }

    #[Route('/admin/reject-cart/{id}', name: 'reject_cart', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function rejectCart(int $id, EntityManagerInterface $em, Request $request): JsonResponse
    {
        $cart = $em->getRepository(Cart::class)->find($id);
        
        if (!$cart || $cart->getStatus() !== 'pending') {
            return new JsonResponse(['success' => false, 'message' => 'Invalid cart for rejection']);
        }

        // Verify CSRF token if coming from web form
        if ($request->isMethod('POST') && !$this->isCsrfTokenValid('reject'.$cart->getId(), $request->request->get('_token'))) {
            return new JsonResponse(['success' => false, 'message' => 'Invalid CSRF token']);
        }

        // Update cart with rejection info
        $cart->setStatus('rejected');
        $cart->setProcessedBy($this->getUser());
        $cart->setProcessedAt(new \DateTime());
        
        $em->flush();

        return new JsonResponse([
            'success' => true,
            'message' => 'Cart rejected',
            'cart_id' => $cart->getId()
        ]);
    }

    #[Route('/my-cart', name: 'view_cart')]
    public function viewCart(): Response
    {
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        
        // Load exemplaires from cookie cart
        $items = $this->cartService->getCartItems();
        
        // Get a valid section (first book in cart)
        $section = null;
        if (!empty($items)) {
            $section = $items[0]->getBook()->getSection();
        }
    
        return $this->render('cart/cartView.html.twig', [
            'cart' => null, // No database cart for draft
            'items' => $items,
            'total' => count($items),
            'section' => $section,
        ]);
    }
    
    #[Route('/remove-from-cart/{id}', name: 'remove_from_cart', methods: ['POST'])]
    public function removeFromCart(int $id, EntityManagerInterface $em): Response
    {
        $book = $em->getRepository(Book::class)->find($id);
        
        if (!$book) {
            return new JsonResponse(['success' => false, 'message' => 'Book not found'], 404);
        }
        
        $cookie = $this->cartService->removeBookFromDraftCart($book);
        
        $response = new JsonResponse(['success' => true]);
        $response->headers->setCookie($cookie);
        
        return $response;
    }
}