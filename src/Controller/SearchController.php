<?php

namespace App\Controller;

use App\Repository\BookRepository;
use App\Repository\AuthorRepository;
use App\Repository\PublisherRepository;
use App\Repository\DisciplineRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class SearchController extends AbstractController
{
    #[Route('/search', name: 'search_results')]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function search(
        Request $request,
        BookRepository $bookRepository,
        AuthorRepository $authorRepository,
        PublisherRepository $publisherRepository,
        DisciplineRepository $disciplineRepository
    ): Response {
        // Block LIMITED_ADMIN from accessing search
        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Les administrateurs limités n\'ont pas accès au site principal.');
        }
        
        $query = $request->query->get('q', '');
        $searchType = $request->query->get('search_type', 'title');
        
        $results = [
            'books' => [],
            'authors' => [],
            'publishers' => [],
            'disciplines' => []
        ];
        
        if (!empty(trim($query))) {
            // Recherche ciblée selon le type sélectionné
            switch ($searchType) {
                case 'title':
                    $results['books'] = $bookRepository->searchByTitle($query);
                    break;
                case 'author':
                    $results['authors'] = $authorRepository->searchByName($query);
                    break;
                case 'publisher':
                    $results['publishers'] = $publisherRepository->searchByName($query);
                    break;
                case 'discipline':
                    $results['disciplines'] = $disciplineRepository->searchByName($query);
                    break;
                case 'isbn':
                    $results['books'] = $bookRepository->searchByIsbn($query);
                    break;
                case 'all':
                default:
                    // Recherche globale dans tout
                    $results['books'] = $bookRepository->searchByTitleOrIsbn($query);
                    $results['authors'] = $authorRepository->searchByName($query);
                    $results['publishers'] = $publisherRepository->searchByName($query);
                    $results['disciplines'] = $disciplineRepository->searchByName($query);
                    break;
            }
        }
        
        return $this->render('search/results.html.twig', [
            'query' => $query,
            'searchType' => $searchType,
            'results' => $results,
        ]);
    }
}