<?php

namespace App\Service;

use App\Entity\Order;
use App\Entity\OrderItem;
use TCPDF;

class ReceiptGeneratorService
{
    public function generateRequestReceipt(Order $order): string
    {
        $pdf = new TCPDF('P', 'mm', [58, 150], true, 'UTF-8', false); // 58mm width, typical receipt 
        $pdf->SetCreator(PDF_CREATOR);
        $pdf->SetAuthor('Système Bibliothèque');
        $pdf->SetTitle('Reçu d\'Emprunt Bibliothèque');
        $pdf->SetMargins(4, 4, 4);
        $pdf->setPrintHeader(false);
        $pdf->setPrintFooter(false);
        $pdf->AddPage();

        // Title
        $pdf->SetFont('helvetica', 'B', 12);
        $pdf->Cell(0, 6, 'REÇU BIBLIOTHÈQUE', 0, 1, 'C');
        $pdf->SetFont('helvetica', '', 8);
        $pdf->Cell(0, 4, str_repeat('*', 32), 0, 1, 'C');
        $pdf->Ln(2);

        // Receipt code displayed
        $pdf->SetFont('helvetica', 'B', 9);
        $pdf->Cell(0, 4, $order->getReceiptCode(), 0, 1, 'C');
        $pdf->Ln(1);

        // Barcode for receipt code
        $barcodeData = $order->getReceiptCode();
        $pdf->write1DBarcode($barcodeData, 'C128', null, null, 50, 12, 0.4, ['position'=>'C', 'align'=>'C'], 'N');
        $pdf->Ln(2);

        // Order info
        $pdf->SetFont('helvetica', '', 8);
        $pdf->Cell(0, 4, 'Commande N°: ' . $order->getId(), 0, 1, 'C');
        $pdf->Cell(0, 4, 'Date: ' . $order->getPlacedAt()->format('d/m/Y H:i'), 0, 1, 'C');
        $pdf->Cell(0, 4, 'Étudiant: ' . $order->getLecteur()->getEmail(), 0, 1, 'C');
        $pdf->Ln(2);

        // Table header
        $pdf->SetFont('helvetica', 'B', 8);
        $pdf->Cell(32, 5, 'Livre', 1, 0, 'L');
        $pdf->Cell(20, 5, 'Code-barres', 1, 1, 'L');

        // Table rows
        $pdf->SetFont('helvetica', '', 8);
        foreach ($order->getItems() as $item) {
            $ex = $item->getExemplaire();
            $pdf->Cell(32, 5, mb_strimwidth($ex->getBook()->getTitle(), 0, 20, '...'), 1, 0, 'L');
            $pdf->Cell(20, 5, $ex->getBarcode(), 1, 1, 'L');
        }

        $pdf->Ln(2);
        $pdf->Cell(0, 4, str_repeat('*', 32), 0, 1, 'C');
        $pdf->SetFont('helvetica', 'B', 10);
        $pdf->Cell(0, 6, 'MERCI!', 0, 1, 'C');

        return $pdf->Output('recu_demande.pdf', 'S');
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
        $pdf->Cell(0, 10, 'Date d\'approbation: ' . $order->getProcessedAt()->format('d/m/Y H:i:s'), 0, 1);
        $pdf->Cell(0, 10, 'Étudiant: ' . $order->getLecteur()->getEmail(), 0, 1);
        $pdf->Ln(5);

        // Add table header
        $pdf->Cell(60, 10, 'Titre du Livre', 1);
        $pdf->Cell(60, 10, 'Code-barres', 1);
        $pdf->Cell(60, 10, 'Date de Retour', 1);
        $pdf->Ln();

        // Add items
        foreach ($order->getItems() as $item) {
            $exemplaire = $item->getExemplaire();
            $book = $exemplaire->getBook();
            
            $pdf->Cell(60, 10, $book->getTitle(), 1);
            $pdf->Cell(60, 10, $exemplaire->getBarcode(), 1);
            $pdf->Cell(60, 10, $exemplaire->getReturnDate()->format('d/m/Y'), 1);
            $pdf->Ln();
        }

        // Output PDF
        return $pdf->Output('recu_approbation.pdf', 'S');
    }
} 