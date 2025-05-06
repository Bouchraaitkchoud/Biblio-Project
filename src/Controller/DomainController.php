<?php
// src/Controller/DomainController.php
namespace App\Controller;

use App\Entity\Domain;
use App\Repository\DomainRepository;
use App\Repository\SectionRepository;
use App\Repository\BookRepository;
use App\Repository\AuthorRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;
use Doctrine\ORM\EntityManagerInterface;
use App\Entity\Cart;

class DomainController extends AbstractController
{
    #[Route('/domains', name: 'app_domains')]
    public function index(DomainRepository $domainRepository): Response
    {
        // Fetch all domains from the database
        $domains = $domainRepository->findAll();

        // Render the domains page
        return $this->render('domain/index.html.twig', [
            'domains' => $domains,
        ]);
    }

    #[Route('/domain/{id}/sections', name: 'app_domain_sections', methods: ['GET'])]
    public function getSections(Domain $domain, SectionRepository $sectionRepository): JsonResponse
    {
        // Fetch sections for the given domain
        $sections = $sectionRepository->findBy(['domain' => $domain]);

        // Convert sections to an array of names
        $sectionNames = array_map(function($section) {
            return ['name' => $section->getName()];
        }, $sections);

        // Return the sections as JSON
        return $this->json($sectionNames);
    }

    #[Route('/domains/search', name: 'app_domains_search', methods: ['GET'])]
    public function search(Request $request, DomainRepository $domainRepository, SectionRepository $sectionRepository, BookRepository $bookRepository, AuthorRepository $authorRepository): Response
    {
        // Get the search term and filter from the query parameters
        $searchTerm = $request->query->get('q', '');
        $filter = $request->query->get('filter', 'all');
        
        // Return empty results if search term is empty or too short
        if (empty($searchTerm) || strlen($searchTerm) < 2) {
            return $this->render('search/results.html.twig', [
                'searchTerm' => $searchTerm,
                'filter' => $filter,
                'domains' => [],
                'sections' => [],
                'books' => [],
                'authors' => [],
            ]);
        }

        // Initialize empty arrays for results
        $domains = [];
        $sections = [];
        $books = [];
        $authors = [];

        // Search based on the selected filter
        switch ($filter) {
            case 'domain':
                $domains = $domainRepository->createQueryBuilder('d')
                    ->where('LOWER(d.name) LIKE LOWER(:searchTerm)')
                    ->setParameter('searchTerm', '%' . $searchTerm . '%')
                    ->orderBy('d.name', 'ASC')
                    ->setMaxResults(10)
                    ->getQuery()
                    ->getResult();
                break;
            
            case 'book':
                $books = $bookRepository->findByTitleOrAuthor($searchTerm);
                break;
            
            case 'author':
                $authors = $authorRepository->findByName($searchTerm);
                break;
            
            case 'all':
            default:
                $domains = $domainRepository->createQueryBuilder('d')
                    ->where('LOWER(d.name) LIKE LOWER(:searchTerm)')
                    ->setParameter('searchTerm', '%' . $searchTerm . '%')
                    ->orderBy('d.name', 'ASC')
                    ->setMaxResults(10)
                    ->getQuery()
                    ->getResult();
                
                $sections = $sectionRepository->createQueryBuilder('s')
                    ->where('LOWER(s.name) LIKE LOWER(:searchTerm)')
                    ->setParameter('searchTerm', '%' . $searchTerm . '%')
                    ->orderBy('s.name', 'ASC') 
                    ->setMaxResults(15)
                    ->getQuery()
                    ->getResult();
                
                $books = $bookRepository->findByTitleOrAuthor($searchTerm);
                $authors = $authorRepository->findByName($searchTerm);
                break;
        }

        // Format the domain results
        $formattedDomains = [];
        foreach ($domains as $domain) {
            $formattedDomains[] = [
                'id' => $domain->getId(),
                'name' => $domain->getName()
            ];
        }

        // Format the section results
        $formattedSections = [];
        foreach ($sections as $section) {
            $formattedSections[] = [
                'id' => $section->getId(),
                'name' => $section->getName(),
                'domainId' => $section->getDomain() ? $section->getDomain()->getId() : null,
                'domainName' => $section->getDomain() ? $section->getDomain()->getName() : null
            ];
        }

        // Format the book results
        $formattedBooks = [];
        foreach ($books as $book) {
            // Get author names
            $authorNames = [];
            foreach ($book->getAuthors() as $author) {
                $authorNames[] = $author->getName();
            }
            
            // Convert image BLOB to base64 if exists
            $coverImageBase64 = null;
            $coverImage = $book->getCoverImage();
            if ($coverImage) {
                $coverImageBase64 = 'data:image/jpeg;base64,' . base64_encode($coverImage);
            }
            
            $formattedBooks[] = [
                'id' => $book->getId(),
                'title' => $book->getTitle(),
                'author' => !empty($authorNames) ? implode(', ', $authorNames) : 'Unknown',
                'coverImageBase64' => $coverImageBase64,
                'publicationYear' => $book->getPublicationYear(),
            ];
        }
        
        // Format the author results
        $formattedAuthors = [];
        foreach ($authors as $author) {
            $formattedAuthors[] = [
                'id' => $author->getId(),
                'name' => $author->getName(),
                'bookCount' => count($author->getBooks())
            ];
        }

        // Render the search results template
        return $this->render('search/results.html.twig', [
            'searchTerm' => $searchTerm,
            'filter' => $filter,
            'domains' => $formattedDomains,
            'sections' => $formattedSections,
            'books' => $formattedBooks,
            'authors' => $formattedAuthors,
        ]);
    }

    #[Route('/domain/{id}/books', name: 'domain_books', methods: ['GET'])]
    public function getDomainBooks(Domain $domain, BookRepository $bookRepository, EntityManagerInterface $entityManager): Response
    {
        // Get the current user
        $user = $this->getUser();
        
        // Get all books from all sections in this domain
        $books = $bookRepository->createQueryBuilder('b')
            ->join('b.section', 's')
            ->join('s.domain', 'd')
            ->where('d.id = :domainId')
            ->setParameter('domainId', $domain->getId())
            ->orderBy('b.title', 'ASC')
            ->getQuery()
            ->getResult();

        // Format the books for display
        $formattedBooks = [];
        foreach ($books as $book) {
            // Get author names
            $authorNames = [];
            foreach ($book->getAuthors() as $author) {
                $authorNames[] = $author->getName();
            }
            
            // Convert image BLOB to base64 if exists
            $coverImageBase64 = null;
            $coverImage = $book->getCoverImage();
            if ($coverImage) {
                $coverImageBase64 = 'data:image/jpeg;base64,' . base64_encode($coverImage);
            }
            
            // Check if book is in user's cart by checking its exemplaires
            $inCart = false;
            if ($user) {
                $cartRepository = $entityManager->getRepository(Cart::class);
                $cart = $cartRepository->findOneBy(['user' => $user, 'status' => 'draft']);
                
                if ($cart) {
                    foreach ($cart->getItems() as $item) {
                        if ($item->getExemplaire()->getBook()->getId() === $book->getId()) {
                            $inCart = true;
                            break;
                        }
                    }
                }
            }
            
            $formattedBooks[] = [
                'id' => $book->getId(),
                'title' => $book->getTitle(),
                'author' => !empty($authorNames) ? implode(', ', $authorNames) : 'Unknown',
                'coverImageBase64' => $coverImageBase64,
                'publicationYear' => $book->getPublicationYear(),
                'section' => $book->getSection() ? $book->getSection()->getName() : null,
                'inCart' => $inCart
            ];
        }

        return $this->render('domain/books.html.twig', [
            'domain' => $domain,
            'books' => $formattedBooks
        ]);
    }
}
