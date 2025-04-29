<?php

namespace App\Service;

use App\Entity\Book;
use App\Entity\Cart;
use App\Entity\User;
use App\Entity\Exemplaire;
use App\Entity\CartItem;
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
     * Convert cookie cart to database cart entity
     * 
     * @param User $user The user who owns the cart
     * @return Cart|null The created cart, or null if cart is empty
     */
    public function convertCookieCartToEntity(User $user): ?Cart
    {
        $exemplaires = $this->getCartItems();
        if (empty($exemplaires)) {
            return null;
        }

        $cart = new Cart();
        $cart->setUser($user);
        $cart->setCreatedAt(new \DateTime());
        $cart->setStatus('pending');

        foreach ($exemplaires as $exemplaire) {
            $item = new CartItem();
            $item->setExemplaire($exemplaire);
            $cart->addItem($item);
        }

        $this->entityManager->persist($cart);
        $this->entityManager->flush();
        
        return $cart;
    }
} 