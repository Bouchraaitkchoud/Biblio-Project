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
use Picqer\Barcode\BarcodeGeneratorPNG;

#[IsGranted('ROLE_USER')]
class ReceiptController extends AbstractController
{
    private $logger;
    private $pdf;

    public function __construct(LoggerInterface $logger, Pdf $pdf)
    {
        $this->logger = $logger;
        $this->pdf = $pdf;
    }

    #[Route('/receipt/{id}', name: 'receipt_show')]
    public function show(Receipt $receipt): Response
    {
        try {
            // Log the receipt ID being accessed
            $this->logger->info('Accessing receipt with ID: ' . $receipt->getId());
            
            // Check if the user is allowed to view this receipt
            $user = $this->getUser();
            if (!in_array('ROLE_ADMIN', $user->getRoles()) && $receipt->getOrder()->getLecteur() !== $user) {
                throw $this->createAccessDeniedException('You are not authorized to view this receipt.');
            }
            
            // Generate barcode
            $generator = new BarcodeGeneratorPNG();
            $barcode = base64_encode($generator->getBarcode($receipt->getCode(), $generator::TYPE_CODE_128));
            
            // Render the HTML for the PDF
            $html = $this->renderView('receipt/pdf.html.twig', [
                'receipt' => $receipt,
                'barcode' => $barcode
            ]);
            
            // Generate the PDF
            $pdfContent = $this->pdf->getOutputFromHtml($html);
            
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
            // Log the error with more details
            $this->logger->error('Error generating PDF: ' . $e->getMessage(), [
                'exception' => $e,
                'receipt_id' => $receipt->getId(),
                'trace' => $e->getTraceAsString()
            ]);
            
            // Show error message
            $this->addFlash('error', 'Failed to generate PDF. Please make sure wkhtmltopdf is installed correctly.');
            
            // Redirect back to appropriate page
            if (in_array('ROLE_ADMIN', $user->getRoles())) {
                return $this->redirectToRoute('admin_orders_index');
            } else {
                return $this->redirectToRoute('home');
            }
        }
    }
}