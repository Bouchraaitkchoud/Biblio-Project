<?php

namespace App\Twig;

use App\Service\CartService;
use App\Entity\Cart;
use App\Entity\Order;
use Twig\Extension\AbstractExtension;
use Twig\TwigFunction;

class CartExtension extends AbstractExtension
{
    private CartService $cartService;

    public function __construct(CartService $cartService)
    {
        $this->cartService = $cartService;
    }

    public function getFunctions(): array
    {
        return [
            new TwigFunction('cart_count', [$this, 'getCartCount']),
            new TwigFunction('check_cart_availability', [$this, 'checkCartAvailability']),
        ];
    }

    public function getCartCount(): int
    {
        return count($this->cartService->getDraftCart());
    }

    /**
     * Check if all items in a cart/order are still available
     */
    public function checkCartAvailability(Cart|Order $cartOrOrder): array
    {
        $unavailableBooks = [];
        $availableCount = 0;
        $totalCount = 0;

        foreach ($cartOrOrder->getItems() as $item) {
            $totalCount++;
            $exemplaire = $item->getExemplaire();
            
            // Exemplaire is available if status is 'available'
            $isAvailable = $exemplaire->getStatus() === 'available';
            
            if (!$isAvailable) {
                $unavailableBooks[] = $exemplaire->getBook()->getTitle();
            } else {
                $availableCount++;
            }
        }

        return [
            'all_available' => empty($unavailableBooks),
            'unavailable_books' => $unavailableBooks,
            'available_count' => $availableCount,
            'total_count' => $totalCount
        ];
    }
} 