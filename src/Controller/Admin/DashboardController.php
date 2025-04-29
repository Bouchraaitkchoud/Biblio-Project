<?php

namespace App\Controller\Admin;

use App\Repository\BookRepository;
use App\Repository\CartRepository;
use App\Repository\ExemplaireRepository;
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
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_dashboard')]
    public function index(): Response
    {
        // Get total books count
        $totalBooks = $this->bookRepository->count([]);

        // Get orders counts
        $pendingCount = $this->cartRepository->count(['status' => 'pending']);
        $approvedCount = $this->cartRepository->count(['status' => 'approved']);

        // Get today's returns count
        $today = new \DateTime();
        $today->setTime(0, 0, 0);
        $tomorrow = clone $today;
        $tomorrow->modify('+1 day');

        $qb = $this->entityManager->createQueryBuilder();
        $returnsToday = $qb->select('COUNT(e.id)')
            ->from('App\Entity\Exemplaire', 'e')
            ->where('e.status = :status')
            ->andWhere('e.returnDate >= :today')
            ->andWhere('e.returnDate < :tomorrow')
            ->setParameter('status', 'available')
            ->setParameter('today', $today)
            ->setParameter('tomorrow', $tomorrow)
            ->getQuery()
            ->getSingleScalarResult();

        // Get recent carts
        $recentCarts = $this->cartRepository->findBy(
            [],
            ['createdAt' => 'DESC'],
            5
        );

        // Get pending carts
        $pendingCarts = $this->cartRepository->findBy(
            ['status' => 'pending'],
            ['createdAt' => 'DESC'],
            5
        );

        return $this->render('admin/dashboard/index.html.twig', [
            'totalBooks' => $totalBooks,
            'pendingCount' => $pendingCount,
            'approvedCount' => $approvedCount,
            'returnsToday' => $returnsToday,
            'recentCarts' => $recentCarts,
            'pendingCarts' => $pendingCarts
        ]);
    }
} 