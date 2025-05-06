<?php

namespace App\Controller\Admin;

use App\Repository\BookRepository;
use App\Repository\CartRepository;
use App\Repository\ExemplaireRepository;
use App\Repository\DomainRepository;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin')]
#[IsGranted('ROLE_ADMIN')]
class DashboardController extends AbstractController
{
    public function __construct(
        private BookRepository $bookRepository,
        private CartRepository $cartRepository,
        private ExemplaireRepository $exemplaireRepository,
        private DomainRepository $domainRepository,
        private UserRepository $userRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_dashboard')]
    public function index(): Response
    {
        // Get total counts
        $total_books = $this->bookRepository->count([]);
        $total_orders = $this->cartRepository->count([]);
        $total_users = $this->userRepository->count([]);
        $total_domains = $this->domainRepository->count([]);

        // Get recent orders
        $recent_orders = $this->cartRepository->findBy(
            [],
            ['createdAt' => 'DESC'],
            5
        );

        return $this->render('admin/dashboard/index.html.twig', [
            'total_books' => $total_books,
            'total_orders' => $total_orders,
            'total_users' => $total_users,
            'total_domains' => $total_domains,
            'recent_orders' => $recent_orders
        ]);
    }
} 