<?php

namespace App\Controller\Admin;

use App\Entity\Discipline;
use App\Form\DisciplineType;
use App\Repository\DisciplineRepository;
use App\Service\ImageUploadService;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/disciplines', name: 'admin_disciplines_')]
class DisciplineController extends AbstractController
{
    #[Route('/', name: 'index', methods: ['GET'])]
    public function index(DisciplineRepository $disciplineRepository): Response
    {
        return $this->render('admin/discipline/index.html.twig', [
            'disciplines' => $disciplineRepository->findAll(),
        ]);
    }

    #[Route('/quick-create', name: 'quick_create', methods: ['POST'])]
    public function quickCreate(Request $request, EntityManagerInterface $entityManager): Response
    {
        $data = json_decode($request->getContent(), true);
        $disciplineName = $data['name'] ?? null;

        if (empty($disciplineName)) {
            return $this->json(['error' => 'Discipline name is required'], Response::HTTP_BAD_REQUEST);
        }

        $discipline = new Discipline();
        $discipline->setName($disciplineName);

        $entityManager->persist($discipline);
        $entityManager->flush();

        return $this->json([
            'id' => $discipline->getId(),
            'name' => $discipline->getName()
        ], Response::HTTP_CREATED);
    }

    #[Route('/new', name: 'new', methods: ['GET', 'POST'])]
    public function new(Request $request, EntityManagerInterface $entityManager, ImageUploadService $imageUploadService): Response
    {
        $discipline = new Discipline();
        $form = $this->createForm(DisciplineType::class, $discipline);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Gérer l'upload de l'image
            $imageFile = $form->get('image')->getData();
            if ($imageFile) {
                try {
                    $imageFileName = $imageUploadService->uploadDiscipline($imageFile, $discipline->getName());
                    $discipline->setImage($imageFileName);
                } catch (\Exception $e) {
                    $this->addFlash('error', $e->getMessage());
                    return $this->render('admin/discipline/new.html.twig', [
                        'discipline' => $discipline,
                        'form' => $form,
                    ]);
                }
            }

            $entityManager->persist($discipline);
            $entityManager->flush();

            $this->addFlash('success', 'La discipline a été créée avec succès.');
            return $this->redirectToRoute('admin_disciplines_index');
        }

        return $this->render('admin/discipline/new.html.twig', [
            'discipline' => $discipline,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'show', methods: ['GET'])]
    public function show(Discipline $discipline): Response
    {
        return $this->render('admin/discipline/show.html.twig', [
            'discipline' => $discipline,
        ]);
    }

    #[Route('/{id}/edit', name: 'edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Discipline $discipline, EntityManagerInterface $entityManager, ImageUploadService $imageUploadService): Response
    {
        $oldImage = $discipline->getImage(); // Sauvegarder l'ancienne image
        $form = $this->createForm(DisciplineType::class, $discipline);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Gérer l'upload de la nouvelle image
            $imageFile = $form->get('image')->getData();
            if ($imageFile) {
                try {
                    // Supprimer l'ancienne image si elle existe
                    if ($oldImage) {
                        $imageUploadService->deleteDiscipline($oldImage);
                    }
                    
                    $imageFileName = $imageUploadService->uploadDiscipline($imageFile, $discipline->getName());
                    $discipline->setImage($imageFileName);
                } catch (\Exception $e) {
                    $this->addFlash('error', $e->getMessage());
                    return $this->render('admin/discipline/edit.html.twig', [
                        'discipline' => $discipline,
                        'form' => $form,
                    ]);
                }
            }

            $entityManager->flush();

            $this->addFlash('success', 'La discipline a été modifiée avec succès.');
            return $this->redirectToRoute('admin_disciplines_index');
        }

        return $this->render('admin/discipline/edit.html.twig', [
            'discipline' => $discipline,
            'form' => $form,
        ]);
    }

    #[Route('/{id}', name: 'delete', methods: ['POST'])]
    public function delete(Request $request, Discipline $discipline, EntityManagerInterface $entityManager, ImageUploadService $imageUploadService): Response
    {
        if ($this->isCsrfTokenValid('delete'.$discipline->getId(), $request->request->get('_token'))) {
            // Check if discipline has books associated
            if ($discipline->getBooks()->count() > 0) {
                $this->addFlash('error', 'Impossible de supprimer cette discipline car elle contient des livres. Veuillez d\'abord déplacer ou supprimer les livres associés.');
                return $this->redirectToRoute('admin_disciplines_index');
            }

            // Supprimer l'image associée
            if ($discipline->getImage()) {
                $imageUploadService->deleteDiscipline($discipline->getImage());
            }

            $entityManager->remove($discipline);
            $entityManager->flush();
            $this->addFlash('success', 'La discipline a été supprimée avec succès.');
        }

        return $this->redirectToRoute('admin_disciplines_index');
    }
}
