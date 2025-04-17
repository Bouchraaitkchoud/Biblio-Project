<?php

namespace App\Controller\Admin;

use App\Entity\Cart;
use App\Repository\CartRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin')]
#[IsGranted('ROLE_ADMIN')]
class DashboardController extends AbstractController
{
    public function __construct(
        private CartRepository $cartRepository
    ) {}

    #[Route('/dashboard', name: 'admin_dashboard')]
    public function index(): Response
    {
        // Get pending orders for the orders widget
        $pendingCarts = $this->cartRepository->findBy(['status' => 'pending']);
        $pendingOrdersCount = count($pendingCarts);
        
        // Get recent orders (both pending and approved)
        $recentCarts = $this->cartRepository->findBy(
            [], 
            ['createdAt' => 'DESC'], 
            5
        );

        return $this->render('admin/dashboard/index.html.twig', [
            'pendingOrdersCount' => $pendingOrdersCount,
            'pendingCarts' => $pendingCarts,
            'recentCarts' => $recentCarts,
        ]);
    }
} 