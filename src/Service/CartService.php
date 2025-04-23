<?php

namespace App\Service;

use App\Entity\Book;
use App\Entity\Cart;
use App\Entity\User;
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
     * @return array The cart items (book IDs)
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
            return $cartData['books'] ?? [];
        } catch (\Exception $e) {
            return [];
        }
    }

    /**
     * Add a book to the draft cart in cookies
     * 
     * @param Book $book The book to add
     * @return Cookie The updated cookie
     */
    public function addBookToDraftCart(Book $book): Cookie
    {
        $bookIds = $this->getDraftCart();
        
        // Check if the book is already in the cart
        if (!in_array($book->getId(), $bookIds)) {
            $bookIds[] = $book->getId();
        }

        return $this->createCartCookie($bookIds);
    }

    /**
     * Remove a book from the draft cart in cookies
     * 
     * @param Book $book The book to remove
     * @return Cookie The updated cookie
     */
    public function removeBookFromDraftCart(Book $book): Cookie
    {
        $bookIds = $this->getDraftCart();
        
        $key = array_search($book->getId(), $bookIds);
        if ($key !== false) {
            unset($bookIds[$key]);
            $bookIds = array_values($bookIds); // Re-index array
        }

        return $this->createCartCookie($bookIds);
    }

    /**
     * Create a cookie with the cart data
     * 
     * @param array $bookIds Array of book IDs
     * @return Cookie The cart cookie
     */
    private function createCartCookie(array $bookIds): Cookie
    {
        $cartData = [
            'books' => $bookIds,
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
     * Load books from draft cart cookie
     * 
     * @return array Array of Book entities
     */
    public function getCartBooks(): array
    {
        $bookIds = $this->getDraftCart();
        if (empty($bookIds)) {
            return [];
        }

        return $this->entityManager->getRepository(Book::class)
            ->findBy(['id' => $bookIds]);
    }

    /**
     * Convert cookie cart to database cart entity
     * 
     * @param User $user The user who owns the cart
     * @return Cart|null The created cart, or null if cart is empty
     */
    public function convertCookieCartToEntity(User $user): ?Cart
    {
        $books = $this->getCartBooks();
        if (empty($books)) {
            return null;
        }

        $cart = new Cart();
        $cart->setUser($user);
        $cart->setCreatedAt(new \DateTime());
        $cart->setStatus('pending');

        foreach ($books as $book) {
            $cart->addBook($book);
        }

        $this->entityManager->persist($cart);
        $this->entityManager->flush();
        
        return $cart;
    }
} 