<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Entity\Order; // Add this
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

#[Security("is_granted('ROLE_ADMIN') or is_granted('ROLE_GERER_HISTORIQUE')")]
class HistoriqueController extends AbstractController
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        $this->entityManager = $entityManager;
    }

    #[Route('/admin/historique', name: 'admin_historique_index', methods: ['GET'])]
    public function index(): Response
    {
        $approvedOrders = $this->entityManager->getRepository(Order::class)
            ->createQueryBuilder('o')
            ->leftJoin('o.lecteur', 'l')
            ->leftJoin('o.items', 'oi')
            ->leftJoin('oi.exemplaire', 'e')
            ->leftJoin('e.location', 'loc')
            ->leftJoin('o.processedBy', 'u')
            ->addSelect('l', 'oi', 'e', 'loc', 'u')
            ->where('o.status = :status')
            ->setParameter('status', 'approved')
            ->getQuery()
            ->getResult();

        if (!$approvedOrders) {
            $this->addFlash('warning', 'Aucun emprunt approuvé trouvé.');
        }

        return $this->render('admin/historique/index.html.twig', [
            'approvedOrders' => $approvedOrders,
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
                $order['bookTitle'].' ('.$order['bookBarcode'].')',
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