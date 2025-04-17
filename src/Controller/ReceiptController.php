<?php
// src/Controller/ReceiptController.php
namespace App\Controller;

use App\Entity\Receipt;
use Knp\Snappy\Pdf;
use Psr\Log\LoggerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[IsGranted('ROLE_USER')]
class ReceiptController extends AbstractController
{
    private $logger;

    public function __construct(LoggerInterface $logger)
    {
        $this->logger = $logger;
    }

    #[Route('/receipt/{id}', name: 'receipt_show')]
    public function show(Receipt $receipt, Pdf $knpSnappyPdf): Response
    {
        // Check if the user is allowed to view this receipt
        // Allow ROLE_ADMIN to view any receipt
        $user = $this->getUser();
        if (!in_array('ROLE_ADMIN', $user->getRoles()) && $receipt->getCart()->getUser() !== $user) {
            throw $this->createAccessDeniedException('You are not authorized to view this receipt.');
        }
        
        try {
            // Log the request
            $this->logger->info('Generating receipt PDF for receipt ID: ' . $receipt->getId());
            
            // Render the HTML for the PDF
            $html = $this->renderView('receipt/pdf.html.twig', [
                'receipt' => $receipt
            ]);
            
            // Generate the PDF
            $pdfContent = $knpSnappyPdf->getOutputFromHtml($html);
            
            // Create the response with the PDF content
            $response = new Response(
                $pdfContent,
                Response::HTTP_OK,
                [
                    'Content-Type' => 'application/pdf',
                    'Content-Disposition' => 'inline; filename="receipt-'.$receipt->getCode().'.pdf"'
                ]
            );
            
            return $response;
        } catch (\Exception $e) {
            // Log the detailed error
            $this->logger->error('PDF generation failed: ' . $e->getMessage(), [
                'receipt_id' => $receipt->getId(),
                'exception' => $e,
                'trace' => $e->getTraceAsString()
            ]);
            
            // Show friendly error message to the user
            $this->addFlash('error', 'Failed to generate PDF. Please try again or contact support.');
            
            // If admin, redirect to admin orders page, otherwise go to home
            if (in_array('ROLE_ADMIN', $user->getRoles())) {
                return $this->redirectToRoute('admin_orders_index');
            } else {
                return $this->redirectToRoute('app_domains');
            }
        }
    }
}