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
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Csrf\CsrfTokenManagerInterface;
use Psr\Log\LoggerInterface;

#[Route('/admin/orders')]
#[Security("is_granted('ROLE_ADMIN') or is_granted('ROLE_GERER_COMMANDES')")]
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

    #[Route('/{id}/approve', name: 'admin_order_approve', methods: ['POST'])]
    public function approve(Request $request, Order $order, EntityManagerInterface $em): Response 
    {
        if ($this->isCsrfTokenValid('approve'.$order->getId(), $request->request->get('_token'))) {
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

                $this->addFlash('success', 'Order approved successfully.');
                return $this->redirectToRoute('admin_orders_index', ['status' => 'approved']);
            } catch (\Exception $e) {
                // Rollback transaction on error
                $em->rollback();
                
                $this->logger->error('Error approving order: ' . $e->getMessage(), [
                    'exception' => $e,
                    'order_id' => $order->getId()
                ]);
                
                $this->addFlash('error', 'Failed to approve order. Please try again.');
                return $this->redirectToRoute('admin_orders_index');
            }
        }

        return $this->redirectToRoute('admin_orders_index');
    }

    #[Route('/{id}/reject', name: 'admin_order_reject', methods: ['POST'])]
    public function reject(Request $request, Order $order): Response
    {
        if ($this->isCsrfTokenValid('reject'.$order->getId(), $request->request->get('_token'))) {
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

            $this->addFlash('warning', 'Order has been rejected.');
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
                $this->logger->error('No receipt found for cart', [
                    'cart_id' => $cart->getId(),
                    'cart_status' => $cart->getStatus()
                ]);
                
                $this->addFlash('error', 'No receipt found for this order. Please try approving the order again.');
                return $this->redirectToRoute('admin_orders_index');
            }
            
            // Generate the receipt PDF using the ReceiptController
            return $this->redirectToRoute('receipt_show', ['id' => $receipt->getId()]);
        } catch (\Exception $e) {
            $this->logger->error('Error viewing receipt: ' . $e->getMessage(), [
                'exception' => $e,
                'cart_id' => $cart->getId()
            ]);
            
            $this->addFlash('error', 'Failed to view receipt. Please try again.');
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
}
