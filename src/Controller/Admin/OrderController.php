<?php
// src/Controller/Admin/OrderController.php
//https://localhost:8000/admin/orders/

namespace App\Controller\Admin;

use App\Entity\Cart;
use App\Entity\Receipt;
use App\Repository\CartRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Psr\Log\LoggerInterface;

#[Route('/admin/orders')]
#[IsGranted('ROLE_ADMIN')]
class OrderController extends AbstractController
{
    public function __construct(
        private CartRepository $cartRepository,
        private EntityManagerInterface $em,
        private UrlGeneratorInterface $urlGenerator,
        private LoggerInterface $logger
    ) {}

    #[Route('/', name: 'admin_orders_index')]
    public function index(Request $request): Response
    {
        $status = $request->query->get('status', '');
        $orderBy = $request->query->get('orderBy', 'createdAt');
        $order = $request->query->get('order', 'DESC');
        
        $criteria = [];
        if (!empty($status)) {
            $criteria['status'] = $status;
        }
        
        $carts = $this->cartRepository->findBy(
            $criteria, 
            [$orderBy => $order]
        );
        
        // Get count by status for the statistics
        $pendingCount = $this->cartRepository->count(['status' => 'pending']);
        $approvedCount = $this->cartRepository->count(['status' => 'approved']);
        $rejectedCount = $this->cartRepository->count(['status' => 'rejected']);
        
        return $this->render('admin/order/index.html.twig', [
            'carts' => $carts,
            'currentStatus' => $status,
            'pendingCount' => $pendingCount,
            'approvedCount' => $approvedCount,
            'rejectedCount' => $rejectedCount,
            'currentOrderBy' => $orderBy,
            'currentOrder' => $order,
        ]);
    }

    #[Route('/{id}/approve', name: 'admin_order_approve', methods: ['POST'])]
    public function approve(Request $request, Cart $cart, EntityManagerInterface $em): Response 
    {
        if ($this->isCsrfTokenValid('approve'.$cart->getId(), $request->request->get('_token'))) {
            try {
                // Start transaction
                $em->beginTransaction();

                // Update exemplaire statuses
                foreach ($cart->getItems() as $item) {
                    $exemplaire = $item->getExemplaire();
                    $exemplaire->setStatus('borrowed');
                    $em->persist($exemplaire);
                }

                // Generate receipt
                $receipt = new Receipt();
                $receipt->setCart($cart);
                $receipt->setCode('REC-'.date('Ymd').'-'.strtoupper(uniqid()));
                $receipt->setGeneratedAt(new \DateTime());
                
                // Update cart with approval info
                $cart->setStatus('approved');
                $cart->setProcessedBy($this->getUser());
                $cart->setProcessedAt(new \DateTime());
                
                $em->persist($receipt);
                $em->flush();

                // Commit transaction
                $em->commit();

                // Check if it's an AJAX request
                if ($request->isXmlHttpRequest()) {
                    return new Response('Order approved', Response::HTTP_OK);
                }

                // Add a flash message
                $this->addFlash('success', 'Order approved successfully.');
                
                // For normal POST requests, redirect to the order list - let the receipt be viewed separately
                return $this->redirectToRoute('admin_orders_index', ['status' => 'approved']);
            } catch (\Exception $e) {
                // Rollback transaction on error
                $em->rollback();
                
                $this->logger->error('Error approving order: ' . $e->getMessage(), [
                    'exception' => $e,
                    'cart_id' => $cart->getId()
                ]);
                
                $this->addFlash('error', 'Failed to approve order. Please try again.');
                return $this->redirectToRoute('admin_orders_index');
            }
        }

        return $this->redirectToRoute('admin_orders_index');
    }

    #[Route('/{id}/reject', name: 'admin_order_reject', methods: ['POST'])]
    public function reject(Request $request, Cart $cart): Response
    {
        if ($this->isCsrfTokenValid('reject'.$cart->getId(), $request->request->get('_token'))) {
            $cart->setStatus('rejected');
            $cart->setProcessedBy($this->getUser());
            $cart->setProcessedAt(new \DateTime());
            
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
            return $this->forward('App\Controller\ReceiptController::show', [
                'receipt' => $receipt
            ]);
        } catch (\Exception $e) {
            $this->logger->error('Error viewing receipt: ' . $e->getMessage(), [
                'exception' => $e,
                'cart_id' => $cart->getId()
            ]);
            
            $this->addFlash('error', 'Failed to view receipt. Please try again.');
            return $this->redirectToRoute('admin_orders_index');
        }
    }
}
