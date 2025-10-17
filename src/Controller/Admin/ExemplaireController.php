<?php

namespace App\Controller\Admin;

use App\Entity\Exemplaire;
use App\Form\ExemplaireType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

#[Route('/admin/exemplaires')]
#[Security("is_granted('ROLE_ADMIN') or is_granted('ROLE_GERER_EXEMPLAIRES')")]
class ExemplaireController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/{id}/edit', name: 'admin_exemplaire_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Exemplaire $exemplaire): Response
    {
        $form = $this->createForm(ExemplaireType::class, $exemplaire);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            try {
                $this->entityManager->flush();
                $this->addFlash('success', 'Exemplaire updated successfully.');
                return $this->redirectToRoute('admin_books_show', ['id' => $exemplaire->getBook()->getId()]);
            } catch (\Exception $e) {
                $this->addFlash('error', 'An error occurred while updating the exemplaire.');
            }
        }

        return $this->render('admin/exemplaire/edit.html.twig', [
            'exemplaire' => $exemplaire,
            'form' => $form->createView(),
            'book' => $exemplaire->getBook()
        ]);
    }

    #[Route('/{id}/return', name: 'admin_exemplaire_return', methods: ['POST'])]
    public function returnBook(Request $request, Exemplaire $exemplaire): Response
    {
        if ($this->isCsrfTokenValid('return'.$exemplaire->getId(), $request->request->get('_token'))) {
            try {
                $this->entityManager->beginTransaction();
                $exemplaire->setStatus('available');
                $exemplaire->setReturnDate(new \DateTime());
                $book = $exemplaire->getBook();
                $currentQuantity = $book->getQuantity();
                $book->setQuantity($currentQuantity + 1);
                $this->entityManager->persist($exemplaire);
                $this->entityManager->persist($book);
                $this->entityManager->flush();
                $this->entityManager->commit();
                $this->addFlash('success', 'Book returned successfully.');
            } catch (\Exception $e) {
                $this->entityManager->rollback();
                $this->addFlash('error', 'An error occurred while processing the return.');
            }
        }

        return $this->redirectToRoute('admin_books_show', ['id' => $exemplaire->getBook()->getId()]);
    }

    #[Route('/{id}/mark-returned', name: 'admin_exemplaire_mark_returned', methods: ['POST'])]
    public function markReturned(Request $request, Exemplaire $exemplaire): Response
    {
        if ($exemplaire->getStatus() !== 'borrowed') {
            $this->addFlash('error', 'This book is not currently borrowed.');
            return $this->redirectToRoute('admin_borrowed_exemplaires');
        }

        $condition = $request->request->get('condition');
        $notes = $request->request->get('notes');
        $dateReturned = $request->request->get('date_returned');
        $flagLate = $request->request->get('flag_late');
        $flagDamaged = $request->request->get('flag_damaged');
        $fine = $request->request->get('fine');
        $printReceipt = $request->request->get('print_receipt') === '1';
        $emailReceipt = $request->request->get('email_receipt') === '1';
        $photoFile = $request->files->get('photo');
        $exemplaire->setStatus('available');
        $exemplaire->setReturnDate($dateReturned ? new \DateTime($dateReturned) : new \DateTime());
        $this->entityManager->persist($exemplaire);
        $this->entityManager->flush();

        if ($printReceipt) {
            $request->getSession()->set('return_receipt_data', [
                'barcode' => $exemplaire->getBarcode(),
                'book_title' => $exemplaire->getBook()->getTitle(),
                'condition' => $condition,
                'notes' => $notes,
                'date_returned' => $dateReturned ?: (new \DateTime())->format('Y-m-d'),
                'flag_late' => $flagLate,
                'flag_damaged' => $flagDamaged,
                'fine' => $fine,
                'processed_by' => $this->getUser() instanceof \App\Entity\User ? $this->getUser()->getEmail() : '',
            ]);
            return $this->redirectToRoute('admin_exemplaire_return_receipt', ['id' => $exemplaire->getId()]);
        }

        $this->addFlash('success', 'Book return processed successfully.');
        return $this->redirectToRoute('admin_borrowed_exemplaires');
    }

    #[Route('/{id}/return-details', name: 'admin_exemplaire_return_details', methods: ['GET'])]
    public function returnDetailsForm(Exemplaire $exemplaire): Response
    {
        return $this->render('admin/exemplaire/return_details.html.twig', [
            'exemplaire' => $exemplaire
        ]);
    }

    #[Route('/{id}/return-receipt', name: 'admin_exemplaire_return_receipt', methods: ['GET'])]
    public function returnReceipt(Request $request, Exemplaire $exemplaire): Response
    {
        $returnData = $request->getSession()->get('return_receipt_data');
        if (!$returnData) {
            $this->addFlash('error', 'No return data found for receipt.');
            return $this->redirectToRoute('admin_borrowed_exemplaires');
        }

        $cartItem = $this->entityManager->getRepository(\App\Entity\CartItem::class)
            ->createQueryBuilder('ci')
            ->where('ci.exemplaire = :exemplaire')
            ->setParameter('exemplaire', $exemplaire)
            ->orderBy('ci.addedAt', 'DESC')
            ->setMaxResults(1)
            ->getQuery()
            ->getOneOrNullResult();

        $studentEmail = $cartItem && $cartItem->getCart() && $cartItem->getCart()->getUser()
            ? $cartItem->getCart()->getUser()->getEmail()
            : 'N/A';

        $pdf = new \TCPDF();
        $pdf->AddPage();
        $pdf->SetFont('helvetica', '', 12);
        $pdf->Cell(0, 10, 'Book Return Receipt', 0, 1, 'C');
        $pdf->Ln(5);
        $pdf->SetFont('helvetica', '', 10);
        $pdf->MultiCell(0, 8, 'Student: ' . $studentEmail);
        $pdf->MultiCell(0, 8, 'Barcode: ' . $returnData['barcode']);
        $pdf->MultiCell(0, 8, 'Book Title: ' . $returnData['book_title']);
        $pdf->MultiCell(0, 8, 'Condition: ' . $returnData['condition']);
        $pdf->MultiCell(0, 8, 'Notes: ' . $returnData['notes']);
        $pdf->MultiCell(0, 8, 'Date Returned: ' . $returnData['date_returned']);
        $pdf->MultiCell(0, 8, 'Late: ' . ($returnData['flag_late'] ? 'Yes' : 'No'));
        $pdf->MultiCell(0, 8, 'Damaged: ' . ($returnData['flag_damaged'] ? 'Yes' : 'No'));
        $pdf->MultiCell(0, 8, 'Fine: ' . ($returnData['fine'] ? $returnData['fine'] : 'None'));
        $pdf->Ln(5);
        $pdf->MultiCell(0, 8, 'Processed by: ' . $returnData['processed_by']);
        $pdf->Ln(5);
        $pdf->Cell(0, 10, 'Thank you!', 0, 1, 'C');
        $request->getSession()->remove('return_receipt_data');
        return new Response($pdf->Output('return_receipt.pdf', 'S'), 200, [
            'Content-Type' => 'application/pdf',
            'Content-Disposition' => 'attachment; filename="return_receipt.pdf"'
        ]);
    }
}