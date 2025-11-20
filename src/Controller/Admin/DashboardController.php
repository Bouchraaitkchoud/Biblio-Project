<?php

namespace App\Controller\Admin;

use App\Repository\BookRepository;
use App\Repository\CartRepository;
use App\Repository\OrderRepository;
use App\Repository\ExemplaireRepository;
use App\Repository\DisciplineRepository;
use App\Repository\UserRepository;
use App\Repository\LocationRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin')]
class DashboardController extends AbstractController
{
    public function __construct(
        private BookRepository $bookRepository,
        private CartRepository $cartRepository,
        private OrderRepository $orderRepository,
        private ExemplaireRepository $exemplaireRepository,
        private DisciplineRepository $disciplineRepository,
        private UserRepository $userRepository,
        private LocationRepository $locationRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_dashboard')]
    #[IsGranted('ROLE_ADMIN')] // Only full admins can access dashboard
    public function index(): Response
    {
        // Get total counts
        $total_books = $this->bookRepository->count([]);
        $total_exemplaires = $this->exemplaireRepository->count([]);
        $total_orders = $this->orderRepository->count([]);
        $total_users = $this->userRepository->count([]);
        $total_disciplines = $this->disciplineRepository->count([]);
        $total_locations = $this->locationRepository->count([]);

        // Get recent orders
        $recent_orders = $this->orderRepository->findBy(
            [],
            ['placedAt' => 'DESC'],
            5
        );

        return $this->render('admin/dashboard/index.html.twig', [
            'total_books' => $total_books,
            'total_exemplaires' => $total_exemplaires,
            'total_orders' => $total_orders,
            'total_users' => $total_users,
            'total_disciplines' => $total_disciplines,
            'total_locations' => $total_locations,
            'recent_orders' => $recent_orders
        ]);
    }
}
