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
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/disciplines', name: 'admin_disciplines_')]
#[IsGranted('ROLE_GERER_DISCIPLINES')]
class DisciplineController extends AbstractController
{
    #[Route('/', name: 'index', methods: ['GET'])]
    public function index(DisciplineRepository $disciplineRepository): Response
    {
        return $this->render('admin/discipline/index.html.twig', [
            'disciplines' => $disciplineRepository->findBy([], ['name' => 'ASC']),
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
            // Handle image upload
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

    #[Route('/{id}', name: 'show', requirements: ['id' => '\d+'], methods: ['GET'])]
    public function show(?Discipline $discipline): Response
    {
        if (!$discipline) {
            throw $this->createNotFoundException('Discipline not found.');
        }
        return $this->render('admin/discipline/show.html.twig', [
            'discipline' => $discipline,
        ]);
    }

    #[Route('/{id}/edit', name: 'edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Discipline $discipline, EntityManagerInterface $entityManager, ImageUploadService $imageUploadService): Response
    {
        $oldImage = $discipline->getImage();
        $form = $this->createForm(DisciplineType::class, $discipline);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $imageFile = $form->get('image')->getData();
            if ($imageFile) {
                try {
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
        // Only ROLE_ADMIN can delete (not limited admins)
        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->addFlash('error', 'Vous n\'avez pas la permission de supprimer des disciplines.');
            return $this->redirectToRoute('admin_disciplines_index');
        }

        if ($this->isCsrfTokenValid('delete' . $discipline->getId(), $request->request->get('_token'))) {
            if ($discipline->getBooks()->count() > 0) {
                $this->addFlash('error', 'Impossible de supprimer cette discipline car elle contient des livres. Veuillez d\'abord déplacer ou supprimer les livres associés.');
                return $this->redirectToRoute('admin_disciplines_index');
            }

            if ($discipline->getImage()) {
                $imageUploadService->deleteDiscipline($discipline->getImage());
            }

            $entityManager->remove($discipline);
            $entityManager->flush();
            $this->addFlash('success', 'La discipline a été supprimée avec succès.');
        }

        return $this->redirectToRoute('admin_disciplines_index');
    }

    #[Route('/export-csv', name: 'export_csv', methods: ['GET'])]
    public function exportCsv(DisciplineRepository $disciplineRepository): Response
    {
        $disciplines = $disciplineRepository->findAll();

        // Build CSV header and each discipline row
        $csvData = "ID,Name,Number of Books\n";
        foreach ($disciplines as $discipline) {
            $csvData .= sprintf(
                "%d,%s,%d\n",
                $discipline->getId(),
                str_replace([",", "\n"], [" ", " "], $discipline->getName()),
                $discipline->getBooks()->count()
            );
        }

        $response = new Response($csvData);
        $disposition = $response->headers->makeDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            'disciplines.csv'
        );
        $response->headers->set('Content-Disposition', $disposition);
        $response->headers->set('Content-Type', 'text/csv');

        return $response;
    }
}
