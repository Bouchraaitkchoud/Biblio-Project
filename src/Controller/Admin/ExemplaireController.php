<?php

namespace App\Controller\Admin;

use App\Entity\Exemplaire;
use App\Form\ExemplaireType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/exemplaires')]
#[IsGranted('ROLE_ADMIN')]
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
                // Start transaction
                $this->entityManager->beginTransaction();

                // Update exemplaire status
                $exemplaire->setStatus('available');
                $exemplaire->setReturnDate(new \DateTime());

                // Update book quantity
                $book = $exemplaire->getBook();
                $currentQuantity = $book->getQuantity();
                $book->setQuantity($currentQuantity + 1);

                $this->entityManager->persist($exemplaire);
                $this->entityManager->persist($book);
                $this->entityManager->flush();

                // Commit transaction
                $this->entityManager->commit();

                $this->addFlash('success', 'Book returned successfully.');
            } catch (\Exception $e) {
                // Rollback transaction on error
                $this->entityManager->rollback();
                $this->addFlash('error', 'An error occurred while processing the return.');
            }
        }

        return $this->redirectToRoute('admin_books_show', ['id' => $exemplaire->getBook()->getId()]);
    }
} 