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
} 