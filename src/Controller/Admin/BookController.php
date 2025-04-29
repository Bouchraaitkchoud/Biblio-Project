<?php

namespace App\Controller\Admin;

use App\Entity\Book;
use App\Entity\Author;
use App\Repository\BookRepository;
use App\Repository\AuthorRepository;
use App\Repository\SectionRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use App\Form\ExemplaireType;
use App\Entity\Exemplaire;

#[Route('/admin/books')]
#[IsGranted('ROLE_ADMIN')]
class BookController extends AbstractController
{
    public function __construct(
        private BookRepository $bookRepository,
        private AuthorRepository $authorRepository,
        private SectionRepository $sectionRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_books_index')]
    public function index(Request $request): Response
    {
        $searchTerm = $request->query->get('search');
        $page = max(1, $request->query->getInt('page', 1));
        $limit = 20;
        
        $paginationData = $this->bookRepository->getPaginatedBooks($page, $limit, $searchTerm);
        
        return $this->render('admin/book/index.html.twig', [
            'books' => $paginationData['books'],
            'pagination' => [
                'currentPage' => $paginationData['currentPage'],
                'totalPages' => $paginationData['totalPages'],
                'totalItems' => $paginationData['totalItems'],
            ],
            'searchTerm' => $searchTerm,
        ]);
    }
    
    #[Route('/new', name: 'admin_book_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        $authors = $this->authorRepository->findAll();
        $sections = $this->sectionRepository->findAll();
        
        if ($request->isMethod('POST')) {
            $title = $request->request->get('title');
            $description = $request->request->get('description');
            $publicationYear = $request->request->get('publicationYear');
            $isbn = $request->request->get('isbn');
            $sectionId = $request->request->get('section');
            $authorIds = $request->request->all('authors');
            
            // File upload
            $coverImage = $request->files->get('coverImage');
            
            // Validation
            if (empty($title)) {
                $this->addFlash('error', 'Book title cannot be empty.');
                return $this->redirectToRoute('admin_book_new');
            }
            
            if (empty($sectionId)) {
                $this->addFlash('error', 'Please select a section for the book.');
                return $this->redirectToRoute('admin_book_new');
            }
            
            if (empty($authorIds)) {
                $this->addFlash('error', 'Please select at least one author.');
                return $this->redirectToRoute('admin_book_new');
            }
            
            $section = $this->sectionRepository->find($sectionId);
            if (!$section) {
                $this->addFlash('error', 'Selected section does not exist.');
                return $this->redirectToRoute('admin_book_new');
            }
            
            // Create book
            $book = new Book();
            $book->setTitle($title);
            $book->setDescription($description);
            $book->setIsbn($isbn);
            $book->setSection($section);
            
            if (!empty($publicationYear)) {
                $book->setPublicationYear((int) $publicationYear);
            }
            
            // Handle cover image
            if ($coverImage && $coverImage->isValid()) {
                $book->setCoverImage(file_get_contents($coverImage->getPathname()));
            }
            
            // Add authors
            foreach ($authorIds as $authorId) {
                $author = $this->authorRepository->find($authorId);
                if ($author) {
                    $book->addAuthor($author);
                }
            }
            
            $this->entityManager->persist($book);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Book created successfully.');
            return $this->redirectToRoute('admin_books_index');
        }
        
        return $this->render('admin/book/new.html.twig', [
            'authors' => $authors,
            'sections' => $sections,
        ]);
    }
    
    #[Route('/{id}', name: 'admin_books_show', methods: ['GET'])]
    public function show(Book $book): Response
    {
        return $this->render('admin/book/show.html.twig', [
            'book' => $book,
            'exemplaires' => $book->getExemplaires()
        ]);
    }
    
    #[Route('/{id}/edit', name: 'admin_book_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Book $book): Response
    {
        $authors = $this->authorRepository->findAll();
        $sections = $this->sectionRepository->findAll();
        
        if ($request->isMethod('POST')) {
            $title = $request->request->get('title');
            $description = $request->request->get('description');
            $publicationYear = $request->request->get('publicationYear');
            $isbn = $request->request->get('isbn');
            $sectionId = $request->request->get('section');
            $authorIds = $request->request->all('authors');
            
            // File upload
            $coverImage = $request->files->get('coverImage');
            
            // Validation
            if (empty($title)) {
                $this->addFlash('error', 'Book title cannot be empty.');
                return $this->redirectToRoute('admin_book_edit', ['id' => $book->getId()]);
            }
            
            if (empty($sectionId)) {
                $this->addFlash('error', 'Please select a section for the book.');
                return $this->redirectToRoute('admin_book_edit', ['id' => $book->getId()]);
            }
            
            if (empty($authorIds)) {
                $this->addFlash('error', 'Please select at least one author.');
                return $this->redirectToRoute('admin_book_edit', ['id' => $book->getId()]);
            }
            
            $section = $this->sectionRepository->find($sectionId);
            if (!$section) {
                $this->addFlash('error', 'Selected section does not exist.');
                return $this->redirectToRoute('admin_book_edit', ['id' => $book->getId()]);
            }
            
            // Update book data
            $book->setTitle($title);
            $book->setDescription($description);
            $book->setIsbn($isbn);
            $book->setSection($section);
            
            if (!empty($publicationYear)) {
                $book->setPublicationYear((int) $publicationYear);
            } else {
                $book->setPublicationYear(null);
            }
            
            // Handle cover image
            if ($coverImage && $coverImage->isValid()) {
                $book->setCoverImage(file_get_contents($coverImage->getPathname()));
            }
            
            // Update authors
            // Remove all existing authors first
            foreach ($book->getAuthors()->toArray() as $existingAuthor) {
                $book->removeAuthor($existingAuthor);
            }
            
            // Add selected authors
            foreach ($authorIds as $authorId) {
                $author = $this->authorRepository->find($authorId);
                if ($author) {
                    $book->addAuthor($author);
                }
            }
            
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Book updated successfully.');
            return $this->redirectToRoute('admin_books_index');
        }
        
        return $this->render('admin/book/edit.html.twig', [
            'book' => $book,
            'authors' => $authors,
            'sections' => $sections,
        ]);
    }
    
    #[Route('/{id}/delete', name: 'admin_book_delete', methods: ['POST'])]
    public function delete(Request $request, Book $book): Response
    {
        if ($this->isCsrfTokenValid('delete'.$book->getId(), $request->request->get('_token'))) {
            // Check if any exemplaires are in active carts
            $hasActiveCartItems = $this->entityManager->getRepository('App\Entity\CartItem')
                ->createQueryBuilder('ci')
                ->join('ci.exemplaire', 'e')
                ->join('ci.cart', 'c')
                ->where('e.book = :book')
                ->andWhere('c.status = :status')
                ->setParameter('book', $book)
                ->setParameter('status', 'pending')
                ->getQuery()
                ->getOneOrNullResult() !== null;

            if ($hasActiveCartItems) {
                $this->addFlash('error', 'Cannot delete book that has items in active carts.');
                return $this->redirectToRoute('admin_books_index');
            }
            
            $this->entityManager->remove($book);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Book deleted successfully.');
        }
        
        return $this->redirectToRoute('admin_books_index');
    }

    #[Route('/{id}/add-exemplaire', name: 'admin_book_add_exemplaire', methods: ['GET', 'POST'])]
    public function addExemplaire(Request $request, Book $book): Response
    {
        $exemplaire = new Exemplaire();
        $exemplaire->setBook($book);
        
        $form = $this->createForm(ExemplaireType::class, $exemplaire);
        $form->handleRequest($request);
        
        if ($form->isSubmitted() && $form->isValid()) {
            try {
                // Start transaction
                $this->entityManager->beginTransaction();
                
                // Set default status if not provided
                if (!$exemplaire->getStatus()) {
                    $exemplaire->setStatus('available');
                }
                
                // Set default section if not provided
                if (!$exemplaire->getSectionId()) {
                    $exemplaire->setSectionId($book->getSection()->getId());
                }
                
                $this->entityManager->persist($exemplaire);
                $this->entityManager->flush();
                
                // Commit transaction
                $this->entityManager->commit();
                
                $this->addFlash('success', 'Exemplaire added successfully.');
                return $this->redirectToRoute('admin_books_show', ['id' => $book->getId()]);
            } catch (\Exception $e) {
                // Rollback transaction on error
                $this->entityManager->rollback();
                
                $this->addFlash('error', 'An error occurred while adding the exemplaire. Please try again.');
                // Log the error for debugging
                error_log('Error adding exemplaire: ' . $e->getMessage());
            }
        }
        
        return $this->render('admin/book/add_exemplaire.html.twig', [
            'book' => $book,
            'form' => $form->createView()
        ]);
    }
} 