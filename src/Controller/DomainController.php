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

        // Search for domains, sections, books, and authors
        $domains = $domainRepository->findByName($searchTerm);
        $sections = $sectionRepository->findByName($searchTerm);
        $books = $bookRepository->findByTitleOrAuthor($searchTerm);

        // Combine the results into a single array
        $results = [
            'domains' => $domains,
            'sections' => $sections,
            'books' => $books,
        ];

        // Return the search results as JSON
        return $this->json($results);
    }
}
