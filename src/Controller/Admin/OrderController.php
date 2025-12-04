<?php
// src/Controller/Admin/OrderController.php
//https://localhost:8000/admin/orders/

namespace App\Controller\Admin;

use App\Entity\Cart;
use App\Entity\Order;
use App\Entity\Receipt;
use App\Repository\CartRepository;
use App\Repository\OrderRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Csrf\CsrfTokenManagerInterface;
use Psr\Log\LoggerInterface;

#[Route('/admin/orders')]
#[IsGranted('ROLE_GERER_COMMANDES')]
class OrderController extends AbstractController
{
    public function __construct(
        private CartRepository $cartRepository,
        private OrderRepository $orderRepository,
        private EntityManagerInterface $em,
        private UrlGeneratorInterface $urlGenerator,
        private CsrfTokenManagerInterface $csrfTokenManager,
        private LoggerInterface $logger
    ) {}

    #[Route('/', name: 'admin_orders_index')]
    public function index(Request $request): Response
    {
        $status = $request->query->get('status', '');
        $orderBy = $request->query->get('orderBy', 'placedAt');
        $order = $request->query->get('order', 'DESC');

        $qb = $this->orderRepository->createQueryBuilder('o')
            ->leftJoin('o.lecteur', 'l')
            ->leftJoin('o.processedBy', 'u')
            ->addSelect('l', 'u');

        if (!empty($status)) {
            $qb->where('o.status = :status')
                ->setParameter('status', $status);
        }

        $qb->orderBy('o.' . $orderBy, $order);

        $orders = $qb->getQuery()->getResult();

        // Get count by status for the statistics
        $pendingCount = $this->orderRepository->count(['status' => 'pending']);
        $approvedCount = $this->orderRepository->count(['status' => 'approved']);
        $rejectedCount = $this->orderRepository->count(['status' => 'rejected']);

        return $this->render('admin/order/index.html.twig', [
            'orders' => $orders,
            'currentStatus' => $status,
            'pendingCount' => $pendingCount,
            'approvedCount' => $approvedCount,
            'rejectedCount' => $rejectedCount,
            'currentOrderBy' => $orderBy,
            'currentOrder' => $order,
        ]);
    }

    #[Route('/search', name: 'admin_orders_search', methods: ['POST'])]
    public function search(Request $request): Response
    {
        $searchTerm = trim($request->request->get('search', ''));

        if (empty($searchTerm)) {
            return $this->json([
                'success' => false,
                'message' => 'Veuillez entrer un ID de commande ou un code de reçu'
            ], 400);
        }

        // Check if it's numeric (order ID)
        if (is_numeric($searchTerm)) {
            $order = $this->orderRepository->find((int)$searchTerm);

            if ($order) {
                return $this->json([
                    'success' => true,
                    'order' => [
                        'id' => $order->getId(),
                        'status' => $order->getStatus(),
                        'placedAt' => $order->getPlacedAt()->format('d/m/Y à H:i'),
                        'lecteur' => [
                            'nom' => $order->getLecteur()->getNom(),
                            'prenom' => $order->getLecteur()->getPrenom(),
                            'email' => $order->getLecteur()->getEmail(),
                        ],
                        'items' => array_map(function ($item) {
                            return [
                                'book_title' => $item->getExemplaire()->getBook()->getTitle(),
                                'barcode' => $item->getExemplaire()->getBarcode(),
                            ];
                        }, $order->getItems()->toArray()),
                        'treatUrl' => $order->getStatus() === 'pending' ? $this->generateUrl('admin_order_treat', ['id' => $order->getId()]) : null
                    ]
                ]);
            }
        }

        // Otherwise, search by receipt code (barcode on the receipt)
        $order = $this->orderRepository->findOneBy(['receiptCode' => $searchTerm]);

        if ($order) {
            return $this->json([
                'success' => true,
                'order' => [
                    'id' => $order->getId(),
                    'status' => $order->getStatus(),
                    'placedAt' => $order->getPlacedAt()->format('d/m/Y à H:i'),
                    'lecteur' => [
                        'nom' => $order->getLecteur()->getNom(),
                        'prenom' => $order->getLecteur()->getPrenom(),
                        'email' => $order->getLecteur()->getEmail(),
                    ],
                    'items' => array_map(function ($item) {
                        return [
                            'book_title' => $item->getExemplaire()->getBook()->getTitle(),
                            'barcode' => $item->getExemplaire()->getBarcode(),
                        ];
                    }, $order->getItems()->toArray()),
                    'treatUrl' => $order->getStatus() === 'pending' ? $this->generateUrl('admin_order_treat', ['id' => $order->getId()]) : null
                ]
            ]);
        }

        return $this->json([
            'success' => false,
            'message' => 'Aucune commande trouvée pour "' . htmlspecialchars($searchTerm) . '"'
        ], 404);
    }

    #[Route('/{id}/approve', name: 'admin_order_approve', methods: ['POST'])]
    public function approve(Request $request, Order $order, EntityManagerInterface $em): Response
    {
        if ($this->isCsrfTokenValid('approve' . $order->getId(), $request->request->get('_token'))) {
            try {
                // Start transaction
                $em->beginTransaction();

                // Update exemplaire statuses from available to borrowed
                foreach ($order->getItems() as $item) {
                    $exemplaire = $item->getExemplaire();

                    // Update exemplaire status to borrowed
                    $exemplaire->setStatus('borrowed');
                    $em->persist($exemplaire);
                }

                // Update order with approval info
                $order->setStatus('approved');
                $order->setProcessedAt(new \DateTime());
                $order->setProcessedBy($this->getUser());

                $em->persist($order);
                $em->flush();

                // Commit transaction
                $em->commit();

                $this->addFlash('success', 'La commande a été approuvée avec succès.');
                return $this->redirectToRoute('admin_orders_index', ['status' => 'approved']);
            } catch (\Exception $e) {
                // Rollback transaction on error
                $em->rollback();

                $this->logger->error('Error approving order: ' . $e->getMessage(), [
                    'exception' => $e,
                    'order_id' => $order->getId()
                ]);

                $this->addFlash('error', 'Échec de l\'approbation de la commande. Veuillez réessayer.');
                return $this->redirectToRoute('admin_orders_index');
            }
        }

        return $this->redirectToRoute('admin_orders_index');
    }

    #[Route('/{id}/reject', name: 'admin_order_reject', methods: ['POST'])]
    public function reject(Request $request, Order $order): Response
    {
        if ($this->isCsrfTokenValid('reject' . $order->getId(), $request->request->get('_token'))) {
            // Release all exemplaires back to available status
            foreach ($order->getItems() as $item) {
                $exemplaire = $item->getExemplaire();
                if ($exemplaire->getStatus() === 'reserved') {
                    $exemplaire->setStatus('available');
                    $this->em->persist($exemplaire);
                }
            }

            $order->setStatus('rejected');
            $order->setProcessedAt(new \DateTime());
            $order->setProcessedBy($this->getUser());

            $this->em->flush();

            $this->addFlash('warning', 'La commande a été rejetée.');
        }

        return $this->redirectToRoute('admin_orders_index');
    }

    #[Route('/{id}/receipt', name: 'admin_order_receipt', methods: ['GET'])]
    public function viewReceipt(Cart $cart): Response
    {
        try {
            // Find the receipt for this cart
            $receipt = $this->em->getRepository(Receipt::class)->findOneBy(['cart' => $cart]);

            if (!$receipt) {
                $this->logger->error('Aucun reçu trouvé pour le panier', [
                    'cart_id' => $cart->getId(),
                    'cart_status' => $cart->getStatus()
                ]);

                $this->addFlash('error', 'Aucun reçu trouvé pour cette commande. Veuillez réessayer d\'approuver la commande.');
                return $this->redirectToRoute('admin_orders_index');
            }

            // Generate the receipt PDF using the ReceiptController
            return $this->redirectToRoute('receipt_show', ['id' => $receipt->getId()]);
        } catch (\Exception $e) {
            $this->logger->error('Error viewing receipt: ' . $e->getMessage(), [
                'exception' => $e,
                'cart_id' => $cart->getId()
            ]);

            $this->addFlash('error', 'Échec de l\'affichage du reçu. Veuillez réessayer.');
            return $this->redirectToRoute('admin_orders_index');
        }
    }

    #[Route('/csrf-token', name: 'csrf_token_ajax', methods: ['POST'])]
    public function getCsrfToken(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        $tokenId = $data['tokenId'] ?? null;

        if (!$tokenId) {
            return $this->json(['error' => 'Token ID required'], 400);
        }

        $token = $this->csrfTokenManager->getToken($tokenId)->getValue();

        return $this->json(['token' => $token]);
    }

    #[Route('/{id}/treat', name: 'admin_order_treat', methods: ['GET'])]
    public function treatOrder(Order $order): Response
    {
        // Vérifier que la commande est en attente
        if ($order->getStatus() !== 'pending') {
            $this->addFlash('error', 'Cette commande ne peut pas être traitée.');
            return $this->redirectToRoute('admin_orders_index');
        }

        return $this->render('admin/order/treat.html.twig', [
            'order' => $order,
        ]);
    }
}
