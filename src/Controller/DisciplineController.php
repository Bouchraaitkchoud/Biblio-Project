<?php

// src/Controller/DisciplineController.php
namespace App\Controller;

use App\Entity\Discipline;
use App\Repository\DisciplineRepository;
use App\Repository\BookRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DisciplineController extends AbstractController
{
    #[Route('/discipline/{id}/books', name: 'discipline_books')]
    public function showBooks(int $id, Request $request, DisciplineRepository $disciplineRepository, BookRepository $bookRepository): Response
    {
        // Fetch the discipline by ID
        $discipline = $disciplineRepository->find($id);

        if (!$discipline) {
            throw $this->createNotFoundException('Discipline not found');
        }

        // Get search query if provided
        $searchQuery = $request->query->get('q', '');

        // Fetch books belonging to this discipline with optional search
        if (!empty($searchQuery)) {
            $books = $bookRepository->searchInDiscipline($discipline, $searchQuery);
        } else {
            // Use the discipline's books collection since it's a ManyToMany relationship
            $books = $discipline->getBooks()->toArray();
        }

        // Render the books in a template
        return $this->render('discipline/books.html.twig', [
            'discipline' => $discipline,
            'books' => $books,
            'searchQuery' => $searchQuery,
        ]);
    }
}
