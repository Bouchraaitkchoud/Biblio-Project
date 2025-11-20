<?php

namespace App\Service;

use App\Entity\Book;
use App\Entity\Cart;
use App\Entity\Lecteur;
use App\Entity\Exemplaire;
use App\Entity\CartItem;
use App\Entity\Order;
use App\Entity\OrderItem;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Cookie;
use Symfony\Component\HttpFoundation\RequestStack;
use Symfony\Component\HttpFoundation\Response;

class CartService
{
    private const CART_COOKIE_NAME = 'draft_cart';
    private const COOKIE_LIFETIME = 60 * 60 * 24 * 30; // 30 days

    public function __construct(
        private RequestStack $requestStack,
        private EntityManagerInterface $entityManager
    ) {
    }

    /**
     * Get the draft cart from cookies
     * 
     * @return array The cart items (exemplaire IDs)
     */
    public function getDraftCart(): array
    {
        $request = $this->requestStack->getCurrentRequest();
        if (!$request) {
            return [];
        }

        $cookie = $request->cookies->get(self::CART_COOKIE_NAME);
        if (!$cookie) {
            return [];
        }

        try {
            $cartData = json_decode($cookie, true);
            return $cartData['items'] ?? [];
        } catch (\Exception $e) {
            return [];
        }
    }

    /**
     * Add a book to the draft cart in cookies
     * 
     * @param Book $book The book to add
     * @return Cookie The updated cookie
     * @throws \Exception If no available exemplaires
     */
    public function addBookToDraftCart(Book $book): Cookie
    {
        // Find an available exemplaire
        $exemplaire = $this->findAvailableExemplaire($book);
        if (!$exemplaire) {
            throw new \Exception('No available copies of this book');
        }

        $itemIds = $this->getDraftCart();
        
        // Check if the exemplaire is already in the cart
        if (!in_array($exemplaire->getId(), $itemIds)) {
            $itemIds[] = $exemplaire->getId();
        }

        return $this->createCartCookie($itemIds);
    }

    /**
     * Find an available exemplaire for a book
     */
    private function findAvailableExemplaire(Book $book): ?Exemplaire
    {
        return $this->entityManager->getRepository(Exemplaire::class)
            ->findOneBy([
                'book' => $book,
                'status' => 'available'
            ]);
    }

    /**
     * Remove a book from the draft cart in cookies
     * 
     * @param Book $book The book to remove
     * @return Cookie The updated cookie
     */
    public function removeBookFromDraftCart(Book $book): Cookie
    {
        $itemIds = $this->getDraftCart();
        
        // Find the exemplaire ID for this book
        $exemplaire = $this->findAvailableExemplaire($book);
        if ($exemplaire) {
            $key = array_search($exemplaire->getId(), $itemIds);
            if ($key !== false) {
                unset($itemIds[$key]);
                $itemIds = array_values($itemIds); // Re-index array
            }
        }

        return $this->createCartCookie($itemIds);
    }

    /**
     * Create a cookie with the cart data
     * 
     * @param array $itemIds Array of exemplaire IDs
     * @return Cookie The cart cookie
     */
    private function createCartCookie(array $itemIds): Cookie
    {
        $cartData = [
            'items' => $itemIds,
            'timestamp' => time()
        ];

        return Cookie::create(
            self::CART_COOKIE_NAME,
            json_encode($cartData),
            time() + self::COOKIE_LIFETIME,
            '/',
            null,
            false,
            false,
            false,
            Cookie::SAMESITE_LAX
        );
    }

    /**
     * Clear the draft cart cookie
     * 
     * @return Cookie An expired cookie to clear the current one
     */
    public function clearDraftCart(): Cookie
    {
        return Cookie::create(
            self::CART_COOKIE_NAME,
            '',
            1,
            '/',
            null,
            false,
            false,
            false,
            Cookie::SAMESITE_LAX
        );
    }

    /**
     * Load exemplaires from draft cart cookie
     * 
     * @return array Array of Exemplaire entities
     */
    public function getCartItems(): array
    {
        $itemIds = $this->getDraftCart();
        if (empty($itemIds)) {
            return [];
        }

        return $this->entityManager->getRepository(Exemplaire::class)
            ->findBy(['id' => $itemIds]);
    }

    /**
     * Convert cookie cart to database order entity
     * 
     * @param Lecteur $lecteur The lecteur who owns the order
     * @return Order|null The created order, or null if cart is empty
     * @throws \Exception If any exemplaire is no longer available
     */
    public function convertCookieCartToEntity(Lecteur $lecteur): ?Order
    {
        $exemplaires = $this->getCartItems();
        if (empty($exemplaires)) {
            return null;
        }

        // Verify all exemplaires are still available
        $unavailableBooks = [];
        foreach ($exemplaires as $exemplaire) {
            if ($exemplaire->getStatus() !== 'available') {
                $unavailableBooks[] = $exemplaire->getBook()->getTitle();
            }
        }

        if (!empty($unavailableBooks)) {
            throw new \Exception(
                'Les livres suivants ne sont plus disponibles: ' . implode(', ', $unavailableBooks) . 
                '. Veuillez retirer ces livres de votre panier.'
            );
        }

        // Create the order
        $order = new Order();
        $order->setLecteur($lecteur);
        $order->setPlacedAt(new \DateTime());
        $order->setStatus('pending');
        
        // Add order items (exemplaires stay available until admin approves)
        foreach ($exemplaires as $exemplaire) {
            $item = new OrderItem();
            $item->setExemplaire($exemplaire);
            $item->setAddedAt(new \DateTime());
            $order->addItem($item);
        }

        $this->entityManager->persist($order);
        $this->entityManager->flush();
        
        // Generate receipt code with format C + 6-digit padded ID (after flush so we have the ID)
        $receiptCode = 'C' . str_pad($order->getId(), 6, '0', STR_PAD_LEFT);
        $order->setReceiptCode($receiptCode);
        $this->entityManager->flush();
        
        return $order;
    }

    /**
     * Check cart items availability and remove unavailable ones
     * 
     * @return array ['removed' => [...], 'cookie' => Cookie|null]
     */
    public function validateAndCleanCart(): array
    {
        $itemIds = $this->getDraftCart();
        if (empty($itemIds)) {
            return ['removed' => [], 'cookie' => null];
        }

        $exemplaires = $this->entityManager->getRepository(Exemplaire::class)
            ->findBy(['id' => $itemIds]);

        $removedBooks = [];
        $validItemIds = [];

        foreach ($exemplaires as $exemplaire) {
            if ($exemplaire->getStatus() === 'available') {
                $validItemIds[] = $exemplaire->getId();
            } else {
                $removedBooks[] = $exemplaire->getBook()->getTitle();
            }
        }

        // If some items were removed, update the cookie
        $cookie = null;
        if (count($validItemIds) !== count($itemIds)) {
            $cookie = $this->createCartCookie($validItemIds);
        }

        return [
            'removed' => $removedBooks,
            'cookie' => $cookie
        ];
    }
} 