<?php

namespace App\Controller\Admin;

use App\Entity\Author;
use App\Repository\AuthorRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/authors')]
#[IsGranted('ROLE_ADMIN')]
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
            'authors' => $paginationData['authors'],
            'pagination' => [
                'currentPage' => $paginationData['currentPage'],
                'totalPages' => $paginationData['totalPages'],
                'totalItems' => $paginationData['totalItems'],
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
                    'id' => $author->getId(),
                    'name' => $author->getName()
                ]);
            }
            
            return $this->redirectToRoute('admin_authors_index');
        }
        
        return $this->render('admin/author/new.html.twig');
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
            'form' => $form->createView(),
        ]);
    }
    
    #[Route('/{id}/delete', name: 'admin_author_delete', methods: ['POST'])]
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
    
    #[Route('/quick-create', name: 'admin_author_quick_create', methods: ['POST'])]
    public function quickCreate(Request $request): JsonResponse
    {
        $name = $request->request->get('name');
        $bio = $request->request->get('bio', '');
        
        if (empty($name)) {
            return new JsonResponse([
                'success' => false,
                'error' => 'Author name is required.'
            ], 400);
        }
        
        $author = new Author();
        $author->setName($name);
        $author->setBio($bio);
        
        $this->entityManager->persist($author);
        $this->entityManager->flush();
        
        return new JsonResponse([
            'success' => true,
            'id' => $author->getId(),
            'name' => $author->getName()
        ]);
    }
} 