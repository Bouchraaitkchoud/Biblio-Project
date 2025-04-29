<?php

namespace App\Service;

use App\Entity\Cart;
use App\Entity\CartItem;
use TCPDF;

class ReceiptGeneratorService
{
    public function generateRequestReceipt(Cart $cart): string
    {
        $pdf = new TCPDF('P', 'mm', [58, 150], true, 'UTF-8', false); // 58mm width, typical receipt 
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor('Library System');
        $pdf->SetTitle('Library Borrow Receipt');
        $pdf->SetMargins(4, 4, 4);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->AddPage();

        // Title
        $pdf->SetFont('helvetica', 'B', 12);
        $pdf->Cell(0, 6, 'LIBRARY RECEIPT', 0, 1, 'C');
        $pdf->SetFont('helvetica', '', 8);
        $pdf->Cell(0, 4, str_repeat('*', 32), 0, 1, 'C');
        $pdf->Ln(2);

        // Barcode for order (cart) ID at the top
        $barcodeData = (string)$cart->getId();
        $pdf->write1DBarcode($barcodeData, 'C128', null, null, 50, 12, 0.4, ['position'=>'C', 'align'=>'C'], 'N');
        $pdf->Ln(2);

        // Order info
        $pdf->SetFont('helvetica', '', 8);
        $pdf->Cell(0, 4, 'Order #: ' . $cart->getId(), 0, 1, 'C');
        $pdf->Cell(0, 4, 'Date: ' . $cart->getCreatedAt()->format('Y-m-d H:i'), 0, 1, 'C');
        $pdf->Cell(0, 4, 'Student: ' . $cart->getUser()->getEmail(), 0, 1, 'C');
        $pdf->Ln(2);

        // Table header
        $pdf->SetFont('helvetica', 'B', 8);
        $pdf->Cell(32, 5, 'Book', 1, 0, 'L');
        $pdf->Cell(20, 5, 'Barcode', 1, 1, 'L');

        // Table rows
        $pdf->SetFont('helvetica', '', 8);
        foreach ($cart->getItems() as $item) {
            $ex = $item->getExemplaire();
            $pdf->Cell(32, 5, mb_strimwidth($ex->getBook()->getTitle(), 0, 20, '...'), 1, 0, 'L');
            $pdf->Cell(20, 5, $ex->getBarcode(), 1, 1, 'L');
        }

        $pdf->Ln(2);
        $pdf->Cell(0, 4, str_repeat('*', 32), 0, 1, 'C');
        $pdf->SetFont('helvetica', 'B', 10);
        $pdf->Cell(0, 6, 'THANK YOU!', 0, 1, 'C');

        return $pdf->Output('request_receipt.pdf', 'S');
    }

    public function generateApprovalReceipt(Cart $cart): string
    {
        $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

        // Set document information
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor('Library System');
        $pdf->SetTitle('Book Approval Receipt');

        // Set margins
        $pdf->SetMargins(15, 15, 15);
        $pdf->SetHeaderMargin(5);
        $pdf->SetFooterMargin(10);

        // Remove default header/footer
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);

        // Add a page
        $pdf->AddPage();

        // Set font
        $pdf->SetFont('helvetica', '', 12);

        // Add title
        $pdf->Cell(0, 10, 'Book Approval Receipt', 0, 1, 'C');
        $pdf->Ln(5);

        // Add approval details
        $pdf->Cell(0, 10, 'Approval Date: ' . $cart->getProcessedAt()->format('Y-m-d H:i:s'), 0, 1);
        $pdf->Cell(0, 10, 'Student: ' . $cart->getUser()->getEmail(), 0, 1);
        $pdf->Cell(0, 10, 'Approved by: ' . $cart->getProcessedBy()->getEmail(), 0, 1);
        $pdf->Ln(5);

        // Add table header
        $pdf->Cell(60, 10, 'Book Title', 1);
        $pdf->Cell(60, 10, 'Barcode', 1);
        $pdf->Cell(60, 10, 'Return Date', 1);
        $pdf->Ln();

        // Add items
        foreach ($cart->getItems() as $item) {
            $exemplaire = $item->getExemplaire();
            $book = $exemplaire->getBook();
            
            $pdf->Cell(60, 10, $book->getTitle(), 1);
            $pdf->Cell(60, 10, $exemplaire->getBarcode(), 1);
            $pdf->Cell(60, 10, $exemplaire->getReturnDate()->format('Y-m-d'), 1);
            $pdf->Ln();
        }

        // Output PDF
        return $pdf->Output('approval_receipt.pdf', 'S');
    }
} 