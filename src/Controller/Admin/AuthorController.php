<?php
namespace App\Controller\Admin;

use App\Entity\Author;
use App\Repository\AuthorRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

#[Route('/admin/authors')]
#[Security("is_granted('ROLE_ADMIN') or is_granted('ROLE_GERER_AUTEURS')")]
class AuthorController extends AbstractController
{
    public function __construct(
        private AuthorRepository $authorRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_authors_index')]
    public function index(Request $request): Response
    {
        $searchTerm = $request->query->get('search');
        $page = max(1, $request->query->getInt('page', 1));
        $limit = 20;
        
        $paginationData = $this->authorRepository->getPaginatedAuthors($page, $limit, $searchTerm);
        
        return $this->render('admin/author/index.html.twig', [
            'authors'    => $paginationData['authors'],
            'pagination' => [
                'currentPage' => $paginationData['currentPage'],
                'totalPages'  => $paginationData['totalPages'],
                'totalItems'  => $paginationData['totalItems'],
            ],
            'searchTerm' => $searchTerm,
        ]);
    }
    
    #[Route('/new', name: 'admin_author_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $name = $request->request->get('name');
            $bio = $request->request->get('bio');
            
            if (empty($name)) {
                $this->addFlash('error', 'Author name cannot be empty.');
                return $this->render('admin/author/new.html.twig');
            }
            
            $author = new Author();
            $author->setName($name);
            $author->setBio($bio);
            
            $this->entityManager->persist($author);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Author created successfully.');
            
            if ($request->isXmlHttpRequest()) {
                return new JsonResponse([
                    'success' => true,
                    'id'      => $author->getId(),
                    'name'    => $author->getName()
                ]);
            }
            
            return $this->redirectToRoute('admin_authors_index');
        }
        
        return $this->render('admin/author/new.html.twig');
    }
    
    #[Route('/export-csv', name: 'admin_author_export_csv', methods: ['GET'])]
    public function exportCsv(): Response
    {
        $authors = $this->authorRepository->findAll();

        // Build CSV string (modify columns as needed)
        $csvData = "ID,Name,Bio\n";
        foreach ($authors as $author) {
            // Replace commas and newlines to avoid breaking CSV format
            $name = str_replace([",", "\n"], [" ", " "], $author->getName());
            $bio  = str_replace([",", "\n"], [" ", " "], $author->getBio() ?: '');
            $csvData .= sprintf("%d,%s,%s\n", $author->getId(), $name, $bio);
        }

        $response = new Response($csvData);
        $disposition = $response->headers->makeDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            'authors.csv'
        );
        $response->headers->set('Content-Disposition', $disposition);
        $response->headers->set('Content-Type', 'text/csv');

        return $response;
    }
    
    #[Route('/{id}', name: 'admin_author_show', methods: ['GET'])]
    public function show(Author $author): Response
    {
        return $this->render('admin/author/show.html.twig', [
            'author' => $author,
        ]);
    }
    
    #[Route('/{id}/edit', name: 'admin_author_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Author $author): Response
    {
        $form = $this->createForm(\App\Form\AuthorType::class, $author);
        $form->handleRequest($request);
            
        if ($form->isSubmitted() && $form->isValid()) {
            $this->entityManager->flush();
            $this->addFlash('success', 'Author updated successfully.');
            return $this->redirectToRoute('admin_authors_index');
        }
        
        return $this->render('admin/author/edit.html.twig', [
            'author' => $author,
            'form'   => $form->createView(),
        ]);
    }

    #[Route('/quick-create', name: 'admin_author_quick_create', methods: ['POST'])]
    public function quickCreate(Request $request): JsonResponse
    {
        $name = $request->request->get('name');
        $bio = $request->request->get('bio');

        if (empty($name)) {
            return new JsonResponse(['success' => false, 'error' => 'Author name cannot be empty.'], Response::HTTP_BAD_REQUEST);
        }

        $author = new Author();
        $author->setName($name);
        $author->setBio($bio);

        $this->entityManager->persist($author);
        $this->entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'id'      => $author->getId(),
            'name'    => $author->getName()
        ]);
    }

    #[Route('/{id}', name: 'admin_author_delete', methods: ['POST'])]
    public function delete(Request $request, Author $author): Response
    {
        if ($this->isCsrfTokenValid('delete'.$author->getId(), $request->request->get('_token'))) {
            
            // Check if it has books
            if (!$author->getBooks()->isEmpty()) {
                $this->addFlash('error', 'Cannot delete author that has books.');
                return $this->redirectToRoute('admin_authors_index');
            }
            
            $this->entityManager->remove($author);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Author deleted successfully.');
        }
        
        return $this->redirectToRoute('admin_authors_index');
    }
}