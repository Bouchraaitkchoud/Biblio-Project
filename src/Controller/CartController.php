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
use Doctrine\ORM\EntityManagerInterface;
use Psr\Log\LoggerInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class CartController extends AbstractController
{
    private LoggerInterface $logger;

    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    #[Route('/add-to-cart/{id}', name: 'add_to_cart', methods: ['POST'])]
    public function addToCart(int $id, EntityManagerInterface $entityManager, Security $security): JsonResponse
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

            // 3. Find or create cart (get the most recent cart with status 'draft')
            $cart = $entityManager->getRepository(Cart::class)->findOneBy(
                ['user' => $user, 'status' => 'draft'],
                ['createdAt' => 'DESC']
            );

            if (!$cart) {
                $cart = new Cart();
                $cart->setUser($user);
                $cart->setCreatedAt(new \DateTime());
                $cart->setStatus('draft');
                $entityManager->persist($cart);
            }

            // 4. Add book to cart (with duplicate check)
            if (!$cart->getBooks()->contains($book)) {
                $cart->addBook($book);
                $entityManager->flush();
                
                $this->logger->info('Book {bookId} added to cart {cartId}', [
                    'bookId' => $book->getId(),
                    'cartId' => $cart->getId()
                ]);
                
                return new JsonResponse([
                    'success' => true,
                    'message' => 'Book added to cart',
                    'cart_id' => $cart->getId()
                ]);
            }

            return new JsonResponse([
                'success' => true,
                'message' => 'Book already in cart'
            ]);

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
    public function submitCart(EntityManagerInterface $em, Security $security): JsonResponse
    {
        /** @var User $user */
        $user = $security->getUser();
        
        // Get the most recent draft cart
        $cart = $em->getRepository(Cart::class)->findOneBy(
            ['user' => $user, 'status' => 'draft'],
            ['createdAt' => 'DESC']
        );

        if (!$cart || $cart->getBooks()->isEmpty()) {
            return new JsonResponse(['success' => false, 'message' => 'No cart items found']);
        }

        // Change cart status to pending approval
        $cart->setStatus('pending');
        $em->flush();

        return new JsonResponse([
            'success' => true,
            'message' => 'Cart submitted for approval',
            'cart_id' => $cart->getId()
        ]);
    }

    #[Route('/admin/approve-cart/{id}', name: 'approve_cart', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function approveCart(int $id, EntityManagerInterface $em, Request $request): JsonResponse
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

        return new JsonResponse([
            'success' => true,
            'receipt_code' => $receipt->getCode(),
            'cart_id' => $cart->getId()
        ]);
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
    public function viewCart(EntityManagerInterface $em): Response
    {
        $this->denyAccessUnlessGranted('IS_AUTHENTICATED_FULLY');
        
        $user = $this->getUser();
        $cart = $em->getRepository(Cart::class)->findOneBy([
            'user' => $user,
            'status' => 'draft'
        ], ['createdAt' => 'DESC']);
    
        // Get a valid section (first book in cart)
        $section = null;
        if ($cart && !$cart->getBooks()->isEmpty()) {
            $section = $cart->getBooks()->first()->getSection();
        }
    
        return $this->render('cart/cartView.html.twig', [
            'cart' => $cart,
            'books' => $cart?->getBooks() ?? [],
            'total' => $cart ? count($cart->getBooks()) : 0,
            'section' => $section,
        ]);
    }
    
    #[Route('/remove-from-cart/{id}', name: 'remove_from_cart', methods: ['POST'])]
    public function removeFromCart(int $id, EntityManagerInterface $em): JsonResponse
    {
        $book = $em->getRepository(Book::class)->find($id);
        $user = $this->getUser();
        
        // Get the most recent draft cart
        $cart = $em->getRepository(Cart::class)->findOneBy(
            ['user' => $user, 'status' => 'draft'],
            ['createdAt' => 'DESC']
        );
        
        if ($cart && $book) {
            $cart->removeBook($book);
            $em->flush();
            return new JsonResponse(['success' => true]);
        }
        
        return new JsonResponse(['success' => false]);
    }
}