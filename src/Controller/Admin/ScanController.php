<?php

namespace App\Controller\Admin;

use App\Entity\Cart;
use App\Entity\Exemplaire;
use App\Entity\CartItem;
use App\Service\ReceiptGeneratorService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/scan')]
#[IsGranted('ROLE_ADMIN')]
class ScanController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager,
        private ReceiptGeneratorService $receiptGenerator
    ) {}

    #[Route('/barcode', name: 'admin_scan_barcode', methods: ['POST'])]
    public function scanBarcode(Request $request): Response
    {
        $data = json_decode($request->getContent(), true);
        $barcode = $data['barcode'] ?? null;

        if (!$barcode) {
            return new JsonResponse(['success' => false, 'message' => 'No barcode provided'], 400);
        }

        // Find exemplaire by barcode
        $exemplaire = $this->entityManager->getRepository(Exemplaire::class)
            ->findOneBy(['barcode' => $barcode]);

        if (!$exemplaire) {
            return new JsonResponse(['success' => false, 'message' => 'Exemplaire not found'], 404);
        }

        // Find cart item with this exemplaire
        $cartItem = $this->entityManager->getRepository(CartItem::class)
            ->findOneBy(['exemplaire' => $exemplaire]);

        if (!$cartItem) {
            return new JsonResponse(['success' => false, 'message' => 'No pending request found for this exemplaire'], 404);
        }

        $cart = $cartItem->getCart();

        // Return cart details for approval
        return new JsonResponse([
            'success' => true,
            'cart_id' => $cart->getId(),
            'student' => $cart->getUser()->getEmail(),
            'request_date' => $cart->getCreatedAt()->format('Y-m-d H:i:s'),
            'items' => array_map(function($item) {
                return [
                    'book_title' => $item->getExemplaire()->getBook()->getTitle(),
                    'barcode' => $item->getExemplaire()->getBarcode()
                ];
            }, $cart->getItems()->toArray())
        ]);
    }

    #[Route('/approve/{id}', name: 'admin_scan_approve', methods: ['POST'])]
    public function approveScannedCart(int $id, Request $request): Response
    {
        $cart = $this->entityManager->getRepository(Cart::class)->find($id);
        
        if (!$cart || $cart->getStatus() !== 'pending') {
            return new JsonResponse(['success' => false, 'message' => 'Invalid cart for approval']);
        }

        try {
            // Start transaction
            $this->entityManager->beginTransaction();

            // Update exemplaire statuses
            foreach ($cart->getItems() as $item) {
                $exemplaire = $item->getExemplaire();
                $exemplaire->setStatus('borrowed');
                $this->entityManager->persist($exemplaire);
            }

            // Update cart with approval info
            $cart->setStatus('approved');
            $cart->setProcessedBy($this->getUser());
            $cart->setProcessedAt(new \DateTime());
            
            $this->entityManager->flush();

            // Generate approval receipt
            $pdfContent = $this->receiptGenerator->generateApprovalReceipt($cart);

            // Commit transaction
            $this->entityManager->commit();

            // Return PDF
            return new Response($pdfContent, 200, [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'attachment; filename="approval_receipt.pdf"'
            ]);
        } catch (\Exception $e) {
            // Rollback transaction on error
            $this->entityManager->rollback();
            
            return new JsonResponse([
                'success' => false,
                'message' => 'An error occurred while approving the cart'
            ], 500);
        }
    }
} 