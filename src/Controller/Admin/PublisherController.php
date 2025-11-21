<?php

namespace App\Controller\Admin;

use App\Entity\Publisher;
use App\Repository\PublisherRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/publishers')]
#[IsGranted('ROLE_GERER_EDITEURS')]
class PublisherController extends AbstractController
{
    public function __construct(
        private PublisherRepository $publisherRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_publishers_index')]
    public function index(Request $request): Response
    {
        $searchTerm = $request->query->get('search');
        $page = max(1, $request->query->getInt('page', 1));
        $limit = 20;

        $paginationData = $this->publisherRepository->getPaginatedPublishers($page, $limit, $searchTerm);

        return $this->render('admin/publisher/index.html.twig', [
            'publishers' => $paginationData['publishers'],
            'pagination' => [
                'currentPage' => $paginationData['currentPage'],
                'totalPages' => $paginationData['totalPages'],
                'totalItems' => $paginationData['totalItems'],
            ],
            'searchTerm' => $searchTerm,
        ]);
    }

    #[Route('/export-csv', name: 'admin_publisher_export_csv', methods: ['GET'])]
    public function exportCsv(): Response
    {
        $publishers = $this->publisherRepository->findAll();

        // Build CSV string with only ID and Name
        $csvData = "ID,Name\n";
        foreach ($publishers as $publisher) {
            // Replace commas and newlines to avoid breaking CSV format
            $name = str_replace([",", "\n"], [" ", " "], $publisher->getName());

            $csvData .= sprintf(
                "%d,%s\n",
                $publisher->getId(),
                $name
            );
        }

        $response = new Response($csvData);
        $disposition = $response->headers->makeDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            'publishers.csv'
        );
        $response->headers->set('Content-Disposition', $disposition);
        $response->headers->set('Content-Type', 'text/csv');

        return $response;
    }

    #[Route('/new', name: 'admin_publisher_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $name = $request->request->get('name');

            if (empty($name)) {
                $this->addFlash('error', "Le nom de l'éditeur ne peut pas être vide.");
                return $this->render('admin/publisher/new.html.twig');
            }

            $publisher = new Publisher();
            $publisher->setName($name);

            $this->entityManager->persist($publisher);
            $this->entityManager->flush();

            $this->addFlash('success', "Éditeur créé avec succès.");

            if ($request->isXmlHttpRequest()) {
                return new JsonResponse([
                    'success' => true,
                    'id' => $publisher->getId(),
                    'name' => $publisher->getName()
                ]);
            }

            return $this->redirectToRoute('admin_publishers_index');
        }

        return $this->render('admin/publisher/new.html.twig');
    }

    #[Route('/{id}', name: 'admin_publisher_show', methods: ['GET'])]
    public function show(Publisher $publisher): Response
    {
        return $this->render('admin/publisher/show.html.twig', [
            'publisher' => $publisher,
        ]);
    }

    #[Route('/{id}/edit', name: 'admin_publisher_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Publisher $publisher): Response
    {
        $form = $this->createForm(\App\Form\PublisherType::class, $publisher);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->entityManager->flush();
            $this->addFlash('success', "Mise à jour de l'éditeur réussie.");
            return $this->redirectToRoute('admin_publishers_index');
        }

        return $this->render('admin/publisher/edit.html.twig', [
            'publisher' => $publisher,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}/delete', name: 'admin_publisher_delete', methods: ['POST'])]
    public function delete(Request $request, Publisher $publisher): Response
    {
        // Only ROLE_ADMIN can delete (not limited admins)
        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->addFlash('error', 'Vous n\'avez pas la permission de supprimer des éditeurs.');
            return $this->redirectToRoute('admin_publishers_index');
        }

        if ($this->isCsrfTokenValid('delete' . $publisher->getId(), $request->request->get('_token'))) {
            // Check if it has books
            if (!$publisher->getBooks()->isEmpty()) {
                $this->addFlash('error', 'Impossible de supprimer un éditeur qui possède des livres.');
                return $this->redirectToRoute('admin_publishers_index');
            }

            $this->entityManager->remove($publisher);
            $this->entityManager->flush();

            $this->addFlash('success', 'Éditeur supprimé avec succès.');
        }

        return $this->redirectToRoute('admin_publishers_index');
    }

    #[Route('/quick-create', name: 'admin_publisher_quick_create', methods: ['POST'])]
    public function quickCreate(Request $request): JsonResponse
    {
        $name = $request->request->get('name');

        if (empty($name)) {
            return new JsonResponse([
                'success' => false,
                'error' => "Le nom de l'éditeur est obligatoire."
            ], 400);
        }

        $publisher = new Publisher();
        $publisher->setName($name);

        $this->entityManager->persist($publisher);
        $this->entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'id' => $publisher->getId(),
            'name' => $publisher->getName()
        ]);
    }
}
