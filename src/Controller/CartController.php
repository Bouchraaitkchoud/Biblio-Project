<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Bundle\SecurityBundle\Security;
use App\Entity\Book;
use App\Entity\Cart;
use App\Entity\Order;
use App\Entity\User;
use App\Entity\Receipt;
use App\Service\CartService;
use Doctrine\ORM\EntityManagerInterface;
use Psr\Log\LoggerInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use App\Service\ReceiptGeneratorService;
use App\Service\ConfigService;

class CartController extends AbstractController
{
    private LoggerInterface $logger;
    private CartService $cartService;
    private ReceiptGeneratorService $receiptGenerator;

    public function __construct(
        LoggerInterface $logger,
        CartService $cartService,
        ReceiptGeneratorService $receiptGenerator,
        private ConfigService $configService // Ajoute ici
    ) {
        $this->logger = $logger;
        $this->cartService = $cartService;
        $this->receiptGenerator = $receiptGenerator;
    }

    #[Route('/add-to-cart/{id}', name: 'add_to_cart', methods: ['POST'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function addToCart(int $id, EntityManagerInterface $entityManager, Security $security): Response
    {
        // Block admins from accessing cart - only students (lecteurs) can order books
        $user = $security->getUser();
        if ($user && in_array('ROLE_ADMIN', $user->getRoles())) {
            return new JsonResponse([
                'success' => false,
                'message' => 'Vous êtes connecté avec un compte administrateur. Les administrateurs ne peuvent pas commander des livres.'
            ], 403);
        }

        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            return new JsonResponse([
                'success' => false,
                'message' => 'Vous êtes connecté avec un compte administrateur. Les administrateurs ne peuvent pas commander des livres.'
            ], 403);
        }

        try {
            // 1. Fetch the book
            $book = $entityManager->getRepository(Book::class)->find($id);
            if (!$book) {
                $this->logger->error('Book not found with ID: {id}', ['id' => $id]);
                return new JsonResponse(['success' => false, 'message' => 'Book not found'], 404);
            }

            // 2. Check if book is available
            if (!$book->isAvailable()) {
                $this->logger->warning('Attempt to add unavailable book to cart: {bookId}', ['bookId' => $id]);
                return new JsonResponse([
                    'success' => false,
                    'message' => 'Ce livre n\'est pas disponible actuellement'
                ], 400);
            }

            // 3. Get authenticated user
            /** @var User $user */
            $user = $security->getUser();
            if (!$user) {
                return new JsonResponse(['success' => false, 'message' => 'Authentication required'], 401);
            }

            try {
                // Récupère la limite maximale
                $maxBooks = $this->configService->getMaxBooksPerOrder();

                // Vérifie le nombre de livres actuels
                $items = $this->cartService->getCartItems();

                if (count($items) >= $maxBooks) {
                    return new JsonResponse([
                        'success' => false,
                        'message' => sprintf(
                            '❌ Limite atteinte ! Vous avez déjà %d livre(s) dans votre panier. Vous ne pouvez pas ajouter plus de %d livre(s) par commande.',
                            count($items),
                            $maxBooks
                        ),
                        'limit_reached' => true,
                        'current_count' => count($items),
                        'max_count' => $maxBooks
                    ], 400);
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
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function submitCart(EntityManagerInterface $em, Security $security, Request $request): Response
    {
        // Block LIMITED_ADMIN from submitting cart
        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Les administrateurs limités n\'ont pas accès au panier.');
        }

        /** @var \App\Entity\Lecteur $lecteur */
        $lecteur = $security->getUser();

        if (!$lecteur) {
            return new JsonResponse(['success' => false, 'message' => 'Authentication required'], 401);
        }

        try {
            // Convert cookie cart to database order entity
            $order = $this->cartService->convertCookieCartToEntity($lecteur);

            if (!$order) {
                return new JsonResponse(['success' => false, 'message' => 'No cart items found']);
            }

            // Create and save Receipt entity to database
            $receipt = new \App\Entity\Receipt();
            $receipt->setOrder($order);
            $receipt->setCode($order->getReceiptCode());
            $receipt->setGeneratedAt(new \DateTime());

            $em->persist($receipt);
            $em->flush();

            // Generate the PDF receipt
            try {
                $pdfContent = $this->receiptGenerator->generateRequestReceipt($order);

                // If it's an AJAX request, save PDF temporarily and return URL
                if ($request->isXmlHttpRequest()) {
                    // Save PDF temporarily to public directory
                    $publicDir = $this->getParameter('kernel.project_dir') . '/public/temp';
                    if (!is_dir($publicDir)) {
                        mkdir($publicDir, 0777, true);
                    }

                    $filename = 'receipt_' . $order->getId() . '_' . time() . '.pdf';
                    $filepath = $publicDir . '/' . $filename;
                    file_put_contents($filepath, $pdfContent);

                    $response = new JsonResponse([
                        'success' => true,
                        'message' => 'Demande envoyée avec succès !',
                        'receiptCode' => $order->getReceiptCode(),
                        'orderId' => $order->getId(),
                        'receiptId' => $receipt->getId(),
                        'printUrl' => '/temp/' . $filename
                    ]);

                    $response->headers->setCookie($this->cartService->clearDraftCart());

                    return $response;
                }

                // For non-AJAX requests, return PDF directly
                $response = new Response($pdfContent, 200, [
                    'Content-Type' => 'application/pdf',
                    'Content-Disposition' => 'attachment; filename="receipt_' . $order->getReceiptCode() . '.pdf"'
                ]);

                $response->headers->setCookie($this->cartService->clearDraftCart());

                return $response;
            } catch (\Exception $e) {
                $this->logger->error('Error generating PDF receipt: ' . $e->getMessage(), [
                    'exception' => $e,
                    'order_id' => $order->getId(),
                    'lecteur_id' => $lecteur->getId()
                ]);

                return new JsonResponse([
                    'success' => false,
                    'message' => 'Failed to generate receipt. Please try again.'
                ], 500);
            }
        } catch (\Exception $e) {
            $this->logger->error('Error submitting cart: ' . $e->getMessage(), [
                'exception' => $e,
                'lecteur_id' => $lecteur->getId()
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
        $order = $em->getRepository(Order::class)->find($id);

        if (!$order || $order->getStatus() !== 'pending') {
            return new JsonResponse(['success' => false, 'message' => 'Invalid order for approval']);
        }

        // Verify CSRF token if coming from web form
        if ($request->isMethod('POST') && !$this->isCsrfTokenValid('approve' . $order->getId(), $request->request->get('_token'))) {
            return new JsonResponse(['success' => false, 'message' => 'Invalid CSRF token']);
        }

        // CRITICAL: Check if all exemplaires are still available
        $unavailableBooks = [];
        foreach ($order->getItems() as $item) {
            $exemplaire = $item->getExemplaire();
            if ($exemplaire->getStatus() !== 'available') {
                $unavailableBooks[] = $exemplaire->getBook()->getTitle();
            }
        }

        if (!empty($unavailableBooks)) {
            return new JsonResponse([
                'success' => false,
                'message' => 'Impossible d\'approuver cette demande. Les livres suivants ne sont plus disponibles: ' .
                    implode(', ', $unavailableBooks) .
                    '. Veuillez soit rejeter la demande, soit attendre que les livres redeviennent disponibles.',
                'unavailable_books' => $unavailableBooks
            ], 400);
        }

        try {
            // Start transaction
            $em->beginTransaction();

            // Update exemplaire statuses
            foreach ($order->getItems() as $item) {
                $exemplaire = $item->getExemplaire();
                $exemplaire->setStatus('borrowed');
                $em->persist($exemplaire);
            }

            // Ensure receipt code uses new format C000001 (regenerate if needed)
            if (!$order->getReceiptCode() || !preg_match('/^C\d{6}$/', $order->getReceiptCode())) {
                $receiptCode = 'C' . str_pad($order->getId(), 6, '0', STR_PAD_LEFT);
                $order->setReceiptCode($receiptCode);
            }

            // Update order with approval info
            $order->setStatus('approved');
            $order->setProcessedAt(new \DateTime());
            $order->setReceiptCode($receiptCode);

            $em->persist($order);
            $em->flush();

            // Commit transaction
            $em->commit();

            return $this->redirectToRoute('receipt_show', ['id' => $order->getId()]);
        } catch (\Exception $e) {
            // Rollback transaction on error
            $em->rollback();

            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while approving the order'
            ], 500);
        }
    }

    #[Route('/admin/reject-cart/{id}', name: 'reject_cart', methods: ['POST'])]
    #[IsGranted('ROLE_ADMIN')]
    public function rejectCart(int $id, EntityManagerInterface $em, Request $request): JsonResponse
    {
        $order = $em->getRepository(Order::class)->find($id);

        if (!$order || $order->getStatus() !== 'pending') {
            return new JsonResponse(['success' => false, 'message' => 'Invalid order for rejection']);
        }

        // Verify CSRF token if coming from web form
        if ($request->isMethod('POST') && !$this->isCsrfTokenValid('reject' . $order->getId(), $request->request->get('_token'))) {
            return new JsonResponse(['success' => false, 'message' => 'Invalid CSRF token']);
        }

        // Release all exemplaires back to available status
        foreach ($order->getItems() as $item) {
            $exemplaire = $item->getExemplaire();
            if ($exemplaire->getStatus() === 'reserved') {
                $exemplaire->setStatus('available');
                $em->persist($exemplaire);
            }
        }

        // Update order with rejection info
        $order->setStatus('rejected');
        $order->setProcessedAt(new \DateTime());

        $em->flush();

        return new JsonResponse([
            'success' => true,
            'message' => 'Order rejected',
            'order_id' => $order->getId()
        ]);
    }

    #[Route('/my-cart', name: 'view_cart')]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function viewCart(): Response
    {
        // Block admins from viewing cart - redirect with message
        $user = $this->getUser();
        if ($user && in_array('ROLE_ADMIN', $user->getRoles())) {
            $this->addFlash('error', 'Vous êtes connecté avec un compte administrateur. Les administrateurs ne peuvent pas commander des livres. Connectez-vous avec un compte étudiant pour accéder au panier.');
            return $this->redirectToRoute('admin_dashboard');
        }

        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            $this->addFlash('error', 'Vous êtes connecté avec un compte administrateur. Les administrateurs ne peuvent pas commander des livres. Connectez-vous avec un compte étudiant pour accéder au panier.');
            return $this->redirectToRoute('admin_limited_panel');
        }

        // Validate cart and remove unavailable items
        $validation = $this->cartService->validateAndCleanCart();

        // Load exemplaires from cookie cart (now cleaned)
        $items = $this->cartService->getCartItems();

        // Get a valid discipline (first book in cart)
        $discipline = null;
        if (!empty($items)) {
            $disciplines = $items[0]->getBook()->getDisciplines();
            if (!$disciplines->isEmpty()) {
                $discipline = $disciplines->first();
            }
        }

        $maxBooks = $this->configService->getMaxBooksPerOrder();

        $response = $this->render('cart/cartView.html.twig', [
            'cart' => null, // No database cart for draft
            'items' => $items,
            'total' => count($items),
            'discipline' => $discipline,
            'removedItems' => $validation['removed'], // Pass removed items to template
            'maxBooks' => $maxBooks  // Ajoute ici
        ]);

        // Set updated cookie if items were removed
        if ($validation['cookie']) {
            $response->headers->setCookie($validation['cookie']);
        }

        return $response;
    }

    #[Route('/remove-from-cart/{id}', name: 'remove_from_cart', methods: ['POST'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function removeFromCart(int $id, EntityManagerInterface $em): Response
    {
        // Block admins from removing from cart
        $user = $this->getUser();
        if ($user && in_array('ROLE_ADMIN', $user->getRoles())) {
            return new JsonResponse([
                'success' => false,
                'message' => 'Vous êtes connecté avec un compte administrateur. Les administrateurs ne peuvent pas commander des livres.'
            ], 403);
        }

        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            return new JsonResponse([
                'success' => false,
                'message' => 'Vous êtes connecté avec un compte administrateur. Les administrateurs ne peuvent pas commander des livres.'
            ], 403);
        }

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
