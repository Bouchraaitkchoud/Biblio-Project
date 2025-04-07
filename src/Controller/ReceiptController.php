<?php
// src/Controller/ReceiptController.php
namespace App\Controller;

use App\Entity\Receipt;
use Knp\Snappy\Pdf;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class ReceiptController extends AbstractController
{
    #[Route('/receipt/{id}', name: 'receipt_show')]
    public function show(Receipt $receipt, Pdf $knpSnappyPdf): Response
    {
        $html = $this->renderView('receipt/pdf.html.twig', [
            'receipt' => $receipt
        ]);

        return new Response(
            $knpSnappyPdf->getOutputFromHtml($html),
            200,
            [
                'Content-Type' => 'application/pdf',
                'Content-Disposition' => 'inline; filename="receipt-'.$receipt->getCode().'.pdf"'
            ]
        );
    }
}