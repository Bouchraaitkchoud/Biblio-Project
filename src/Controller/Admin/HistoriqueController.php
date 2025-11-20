<?php

declare(strict_types=1);

namespace App\Controller\Admin;

use App\Entity\Order;
use App\Repository\OrderRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[IsGranted('ROLE_GERER_HISTORIQUE')]
class HistoriqueController extends AbstractController
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('/admin/historique', name: 'admin_historique_index', methods: ['GET'])]
    public function index(Request $request, OrderRepository $orderRepository): Response
    {
        // Get search parameters
        $searchQuery = $request->query->get('search', '');
        $searchType = $request->query->get('searchType', 'all');
        $filterStatus = $request->query->get('status', '');

        // Build query
        $qb = $this->entityManager->getRepository(Order::class)
            ->createQueryBuilder('o')
            ->leftJoin('o.lecteur', 'l')
            ->leftJoin('o.items', 'oi')
            ->leftJoin('oi.exemplaire', 'e')
            ->leftJoin('e.book', 'b')
            ->leftJoin('e.location', 'loc')
            ->leftJoin('o.processedBy', 'u')
            ->addSelect('l', 'oi', 'e', 'loc', 'u', 'b')
            ->where('o.status = :status')
            ->setParameter('status', 'approved')
            ->addOrderBy('o.placedAt', 'DESC');

        // Unified search based on search type
        if (!empty($searchQuery)) {
            $searchTerm = '%' . $searchQuery . '%';

            switch ($searchType) {
                case 'lecteur':
                    // Search by lecteur: nom complet, email
                    $qb->andWhere('(
                        LOWER(CONCAT(l.nom, \' \', l.prenom)) LIKE LOWER(:search) OR
                        LOWER(l.nom) LIKE LOWER(:search) OR
                        LOWER(l.prenom) LIKE LOWER(:search) OR
                        LOWER(l.email) LIKE LOWER(:search)
                    )')
                        ->setParameter('search', $searchTerm);
                    break;

                case 'exemplaire':
                    // Search by exemplaire: titre, code-barres
                    $qb->andWhere('(
                        LOWER(b.title) LIKE LOWER(:search) OR
                        LOWER(e.barcode) LIKE LOWER(:search)
                    )')
                        ->setParameter('search', $searchTerm);
                    break;

                case 'all':
                default:
                    // Global search: everything
                    $qb->andWhere('(
                        LOWER(CONCAT(l.nom, \' \', l.prenom)) LIKE LOWER(:search) OR
                        LOWER(l.email) LIKE LOWER(:search) OR
                        LOWER(b.title) LIKE LOWER(:search) OR
                        LOWER(e.barcode) LIKE LOWER(:search)
                    )')
                        ->setParameter('search', $searchTerm);
                    break;
            }
        }

        // Filter by exemplaire status
        if (!empty($filterStatus)) {
            $qb->andWhere('e.status = :exemplaireStatus')
                ->setParameter('exemplaireStatus', $filterStatus);
        }

        $approvedOrders = $qb->getQuery()->getResult();

        return $this->render('admin/historique/index.html.twig', [
            'approvedOrders' => $approvedOrders,
            'searchQuery' => $searchQuery,
            'searchType' => $searchType,
            'filterStatus' => $filterStatus,
        ]);
    }

    #[Route('/admin/historique/export', name: 'admin_historique_export', methods: ['GET'])]
    public function export(EntityManagerInterface $entityManager): Response
    {
        $query = $entityManager->createQuery(
            'SELECT 
                l.email AS lecteurEmail, 
                o.placedAt, 
                o.returnedAt, 
                b.title AS bookTitle, 
                e.barcode AS bookBarcode, 
                loc.name AS locationName,
                u.email AS adminEmail 
             FROM App\Entity\Order o
             JOIN o.lecteur l
             JOIN o.items oi
             JOIN oi.exemplaire e
             JOIN e.book b
             LEFT JOIN e.location loc
             LEFT JOIN o.processedBy u
             WHERE o.status = :status'
        );
        $query->setParameter('status', 'approved');
        $orders = $query->getResult();

        // Build CSV content from $orders data...
        $csvData = "Lecteur,Date de commande,Date de retour,Exemplaire,Emplacement,Admin traitant\n";
        foreach ($orders as $order) {
            $csvData .= sprintf(
                "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                $order['lecteurEmail'],
                isset($order['placedAt']) ? $order['placedAt']->format('d/m/Y H:i') : '',
                isset($order['returnedAt']) ? $order['returnedAt']->format('d/m/Y H:i') : 'Non retourné',
                $order['bookTitle'] . ' (' . $order['bookBarcode'] . ')',
                $order['locationName'] ?? 'N/A',
                $order['adminEmail'] ?? 'N/A'
            );
        }

        $response = new Response($csvData);
        $disposition = $response->headers->makeDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            'historique.csv'
        );
        $response->headers->set('Content-Disposition', $disposition);
        $response->headers->set('Content-Type', 'text/csv');

        return $response;
    }
}
