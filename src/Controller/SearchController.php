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

class SearchController extends AbstractController
{
    #[Route('/search', name: 'search_results')]
    public function search(
        Request $request,
        BookRepository $bookRepository,
        AuthorRepository $authorRepository,
        PublisherRepository $publisherRepository,
        DisciplineRepository $disciplineRepository
    ): Response {
        $query = $request->query->get('q', '');
        
        $results = [
            'books' => [],
            'authors' => [],
            'publishers' => [],
            'disciplines' => []
        ];
        
        if (!empty(trim($query))) {
            // Recherche dans les livres (titre, ISBN)
            $results['books'] = $bookRepository->searchByTitleOrIsbn($query);
            
            // Recherche dans les auteurs
            $results['authors'] = $authorRepository->searchByName($query);
            
            // Recherche dans les éditeurs
            $results['publishers'] = $publisherRepository->searchByName($query);
            
            // Recherche dans les disciplines
            $results['disciplines'] = $disciplineRepository->searchByName($query);
        }
        
        return $this->render('search/results.html.twig', [
            'query' => $query,
            'results' => $results,
        ]);
    }
}