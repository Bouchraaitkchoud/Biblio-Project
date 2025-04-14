<?php
// src/Controller/DomainController.php
namespace App\Controller;

use App\Entity\Domain;
use App\Repository\DomainRepository;
use App\Repository\SectionRepository;
use App\Repository\BookRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\Annotation\Route;

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
    public function search(Request $request, DomainRepository $domainRepository, SectionRepository $sectionRepository, BookRepository $bookRepository): JsonResponse
    {
        // Get the search term from the query parameters
        $searchTerm = $request->query->get('q', '');
        
        // Return empty results if search term is empty or too short
        if (empty($searchTerm) || strlen($searchTerm) < 2) {
            return $this->json([
                'domains' => [],
                'sections' => [],
                'books' => [],
            ]);
        }

        // Search for domains, sections, books
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
        
        $books = $bookRepository->createQueryBuilder('b')
            ->where('LOWER(b.title) LIKE LOWER(:searchTerm)')
            ->orWhere('LOWER(b.author) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->orderBy('b.title', 'ASC')
            ->setMaxResults(20)
            ->getQuery()
            ->getResult();

        // Format the domain results for better display
        $formattedDomains = [];
        foreach ($domains as $domain) {
            $formattedDomains[] = [
                'id' => $domain->getId(),
                'name' => $domain->getName()
            ];
        }

        // Format the section results for better display
        $formattedSections = [];
        foreach ($sections as $section) {
            $formattedSections[] = [
                'id' => $section->getId(),
                'name' => $section->getName(),
                'domainId' => $section->getDomain() ? $section->getDomain()->getId() : null,
                'domainName' => $section->getDomain() ? $section->getDomain()->getName() : null
            ];
        }

        // Format the book results for better display
        $formattedBooks = [];
        foreach ($books as $book) {
            $formattedBooks[] = [
                'id' => $book->getId(),
                'title' => $book->getTitle(),
                'author' => $book->getAuthor()
            ];
        }

        // Return the optimized search results as JSON
        return $this->json([
            'domains' => $formattedDomains,
            'sections' => $formattedSections,
            'books' => $formattedBooks,
        ]);
    }
}
