<?php

namespace App\Service;

use App\Entity\Order;
use App\Entity\OrderItem;
use TCPDF;

class ReceiptGeneratorService
{
    public function generateRequestReceipt(Order $order): string
    {
        $pdf = new TCPDF('P', 'mm', [58, 200], true, 'UTF-8', false); // 58mm width for thermal printer
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor('Bibliothèque UIASS');
        $pdf->SetTitle('Bon de Retrait Bibliothèque');
        $pdf->SetMargins(6, 3, 6); // Increased margins to prevent text cutoff
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->SetAutoPageBreak(true, 3);
        $pdf->AddPage();

        // Header - Library Name
        $pdf->SetFont('helvetica', 'B', 10);
        $pdf->Cell(0, 5, 'BIBLIOTHÈQUE UIASS', 0, 1, 'C');
        $pdf->SetFont('helvetica', '', 7);
        $pdf->Cell(0, 3, 'Bon de Retrait', 0, 1, 'C');
        $pdf->Cell(0, 3, str_repeat('=', 28), 0, 1, 'C');
        $pdf->Ln(1);

        // Receipt code displayed prominently
        $pdf->SetFont('helvetica', 'B', 14);
        $pdf->Cell(0, 6, $order->getReceiptCode(), 0, 1, 'C');
        $pdf->Ln(1);

        // Barcode for receipt code - adjusted width
        $barcodeData = $order->getReceiptCode();
        $pdf->write1DBarcode($barcodeData, 'C128', null, null, 50, 12, 0.4, ['position' => 'C', 'align' => 'C'], 'N');
        $pdf->Ln(2);

        // Order ID
        $pdf->SetFont('helvetica', '', 7);
        $pdf->Cell(0, 3, 'ID Commande: #' . $order->getId(), 0, 1, 'C');
        $pdf->Ln(1);

        // Student name
        $pdf->SetFont('helvetica', '', 7);
        $pdf->Cell(0, 3, 'Nom et prénom: ' . $order->getLecteur()->getNom() . ' ' . $order->getLecteur()->getPrenom(), 0, 1, 'C');
        $pdf->Ln(1);

        // Date
        $pdf->SetFont('helvetica', '', 7);
        $pdf->Cell(0, 3, 'Date de commande: ' . $order->getPlacedAt()->format('d/m/Y H:i'), 0, 1, 'C');
        $pdf->Ln(1);

        // Order info section - Simple list of books
        $pdf->SetFont('helvetica', '', 7);
        $pdf->Cell(0, 3, 'Livres:', 0, 1, 'L');
        $pdf->Ln(1);

        $bookNumber = 1;
        foreach ($order->getItems() as $item) {
            $ex = $item->getExemplaire();
            $bookTitle = $ex->getBook()->getTitle();

            // Simple numbered list
            $pdf->SetFont('helvetica', 'B', 7);
            $pdf->Cell(5, 4, $bookNumber . '.', 0, 0, 'L');
            $pdf->SetFont('helvetica', '', 7);
            $pdf->MultiCell(0, 4, $bookTitle, 0, 'L', false, 1);
            $pdf->Ln(0.5);
            $bookNumber++;
        }

        $pdf->Ln(1);
        $pdf->SetFont('helvetica', '', 7);
        $pdf->Cell(0, 3, str_repeat('=', 28), 0, 1, 'C');
        $pdf->Ln(2);
        $pdf->SetFont('helvetica', 'B', 10);
        $pdf->Cell(0, 6, 'MERCI!', 0, 1, 'C');

        return $pdf->Output('recu_' . $order->getReceiptCode() . '.pdf', 'S');
    }

    public function generateApprovalReceipt(Order $order): string
    {
        $pdf = new TCPDF(PDF_PAGE_ORIENTATION, PDF_UNIT, PDF_PAGE_FORMAT, true, 'UTF-8', false);

        // Set document information
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor('Système Bibliothèque');
        $pdf->SetTitle('Reçu d\'Approbation d\'Emprunt');

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
        $pdf->Cell(0, 10, 'Reçu d\'Approbation d\'Emprunt', 0, 1, 'C');
        $pdf->Ln(5);

        // Add approval details
        $pdf->Cell(0, 10, 'ID Commande: #' . $order->getId(), 0, 1);
        $pdf->Cell(0, 10, 'Date d\'approbation: ' . $order->getProcessedAt()->format('d/m/Y H:i:s'), 0, 1);
        $pdf->Cell(0, 10, 'Étudiant: ' . $order->getLecteur()->getEmail(), 0, 1);
        $pdf->Ln(5);

        // Add table header
        $pdf->Cell(90, 10, 'Titre du Livre', 1);
        $pdf->Cell(90, 10, 'Code-barres', 1);
        $pdf->Ln();

        // Add items
        foreach ($order->getItems() as $item) {
            $exemplaire = $item->getExemplaire();
            $book = $exemplaire->getBook();

            $pdf->Cell(90, 10, $book->getTitle(), 1);
            $pdf->Cell(90, 10, $exemplaire->getBarcode(), 1);
            $pdf->Ln();
        }

        // Output PDF
        return $pdf->Output('recu_approbation.pdf', 'S');
    }
}
