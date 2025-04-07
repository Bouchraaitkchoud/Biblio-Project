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

#[Route('/admin/orders')]
#[IsGranted('ROLE_ADMIN')]
class OrderController extends AbstractController
{
    public function __construct(
        private CartRepository $cartRepository,
        private EntityManagerInterface $em
    ) {}

    #[Route('/', name: 'admin_orders_index')]
    public function index(): Response
    {
        $pendingCarts = $this->cartRepository->findBy(['status' => 'pending']);

        return $this->render('admin/order/index.html.twig', [
            'carts' => $pendingCarts,
        ]);
    }

    #[Route('/{id}/approve', name: 'admin_order_approve', methods: ['POST'])]
    // public function approve(Request $request, Cart $cart): Response
    // {
    //     if ($this->isCsrfTokenValid('approve'.$cart->getId(), $request->request->get('_token'))) {
    //         $cart->setStatus('approved');
    //         $cart->setProcessedBy($this->getUser());
    //         $cart->setProcessedAt(new \DateTime());

    //         // Generate receipt
    //         $receipt = new Receipt();
    //         $receipt->setCart($cart);
    //         $receipt->setCode('REC-'.date('Ymd').'-'.uniqid());
    //         $receipt->setGeneratedAt(new \DateTime());
            
    //         $this->em->persist($receipt);
    //         $this->em->flush();

    //         $this->addFlash('success', 'Order approved and receipt generated.');
    //     }

    //     return $this->redirectToRoute('admin_orders_index');
    // }
    public function approve(
        Request $request,
        Cart $cart,
        EntityManagerInterface $em
    ): Response {
        if ($this->isCsrfTokenValid('approve'.$cart->getId(), $request->request->get('_token'))) {
            // Generate receipt
            $receipt = new Receipt();
            $receipt->setCart($cart);
            $receipt->setCode('REC-'.date('Ymd').'-'.strtoupper(uniqid()));
            $receipt->setGeneratedAt(new \DateTime());
            
            $cart->setStatus('approved');
            $cart->setProcessedBy($this->getUser());
            $cart->setProcessedAt(new \DateTime());
            
            $em->persist($receipt);
            $em->flush();
    
            // Redirect to PDF view
            return $this->redirectToRoute('receipt_show', ['id' => $receipt->getId()]);
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
}
