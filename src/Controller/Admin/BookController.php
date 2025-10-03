<?php

namespace App\Controller\Admin;

use App\Entity\Book;
use App\Entity\Author;
use App\Repository\BookRepository;
use App\Repository\AuthorRepository;
use App\Repository\DisciplineRepository;
use App\Service\ImageUploadService;
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
        private DisciplineRepository $disciplineRepository,
        private EntityManagerInterface $entityManager,
        private ImageUploadService $imageUploadService
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
        $book = new Book();
        $form = $this->createForm(\App\Form\BookType::class, $book);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Handle cover image upload
            $coverImageFile = $form->get('coverImage')->getData();
            if ($coverImageFile) {
                try {
                    $imageFileName = $this->imageUploadService->uploadBookCover($coverImageFile, $book->getTitle());
                    $book->setCoverImage($imageFileName);
                } catch (\Exception $e) {
                    $this->addFlash('error', $e->getMessage());
                    return $this->render('admin/book/new.html.twig', [
                        'book' => $book,
                        'form' => $form->createView(),
                    ]);
                }
            }

            $this->entityManager->persist($book);
            $this->entityManager->flush();

            $this->addFlash('success', 'Book created successfully.');
            return $this->redirectToRoute('admin_books_index');
        }

        return $this->render('admin/book/new.html.twig', [
            'book' => $book,
            'form' => $form->createView(),
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
        $oldCoverImage = $book->getCoverImage(); // Store old image filename
        $form = $this->createForm(\App\Form\BookType::class, $book);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            // Handle cover image upload
            $coverImageFile = $form->get('coverImage')->getData();
            if ($coverImageFile) {
                try {
                    // Delete old image if exists
                    if ($oldCoverImage) {
                        $this->imageUploadService->deleteBookCover($oldCoverImage);
                    }
                    
                    $imageFileName = $this->imageUploadService->uploadBookCover($coverImageFile, $book->getTitle());
                    $book->setCoverImage($imageFileName);
                } catch (\Exception $e) {
                    $this->addFlash('error', $e->getMessage());
                    return $this->render('admin/book/edit.html.twig', [
                        'book' => $book,
                        'form' => $form->createView(),
                    ]);
                }
            }

            $this->entityManager->flush();
            $this->addFlash('success', 'Book updated successfully.');
            return $this->redirectToRoute('admin_books_index');
        }

        return $this->render('admin/book/edit.html.twig', [
            'book' => $book,
            'form' => $form->createView(),
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
                if (!$exemplaire->getDisciplineId()) {
                    $exemplaire->setDisciplineId($book->getDiscipline()->getId());
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