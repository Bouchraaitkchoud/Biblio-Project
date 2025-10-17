<?php
declare(strict_types=1);

namespace App\Controller\Admin;

use App\Entity\Order; // Add this
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;

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
        $query = $this->entityManager->createQueryBuilder()
            ->select('l.email AS lecteurEmail, o.placedAt AS createdAt, o.status, o.receiptCode, o.processedAt, o.adminEmail')
            ->from(Order::class, 'o')
            ->join('o.user', 'l')
            ->where('o.status = :status')
            ->setParameter('status', 'approved')
            ->getQuery();

        $approvedOrders = $query->getResult();

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
                d.name AS disciplineName,
                o.adminEmail 
             FROM App\Entity\Order o
             JOIN o.user l
             JOIN o.exemplaire e
             JOIN e.book b
             JOIN e.discipline d
             WHERE o.status = :status'
        );
        $query->setParameter('status', 'approved');
        $orders = $query->getResult();
        
        // Build CSV content from $orders data...
        $csvData = "Lecteur,Date de commande,Date de retour,Exemplaire,Discipline,Admin traitant\n";
        foreach ($orders as $order) {
            $csvData .= sprintf(
                "\"%s\",\"%s\",\"%s\",\"%s\",\"%s\",\"%s\"\n",
                $order['lecteurEmail'],
                isset($order['placedAt']) ? $order['placedAt']->format('d/m/Y H:i') : '',
                isset($order['returnedAt']) ? $order['returnedAt']->format('d/m/Y H:i') : 'Non retourné',
                $order['bookTitle'].' ('.$order['bookBarcode'].')',
                $order['disciplineName'],
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