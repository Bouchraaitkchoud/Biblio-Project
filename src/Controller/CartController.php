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

class CartController extends AbstractController
{
    private LoggerInterface $logger;
    private CartService $cartService;

    public function __construct(LoggerInterface $logger, CartService $cartService)
    {
        $this->logger = $logger;
        $this->cartService = $cartService;
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
        
        // Convert cookie cart to database entity
        $cart = $this->cartService->convertCookieCartToEntity($user);
        
        if (!$cart) {
            return new JsonResponse(['success' => false, 'message' => 'No cart items found']);
        }
        
        // Clear the cookie cart
        $response = new JsonResponse([
            'success' => true,
            'message' => 'Cart submitted for approval',
            'cart_id' => $cart->getId()
        ]);
        
        $response->headers->setCookie($this->cartService->clearDraftCart());
        
        return $response;
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

        return $this->redirectToRoute('receipt_show', ['id' => $receipt->getId()]);
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
        
        // Load books from cookie cart
        $books = $this->cartService->getCartBooks();
        
        // Get a valid section (first book in cart)
        $section = null;
        if (!empty($books)) {
            $section = $books[0]->getSection();
        }
    
        return $this->render('cart/cartView.html.twig', [
            'cart' => null, // No database cart for draft
            'books' => $books,
            'total' => count($books),
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