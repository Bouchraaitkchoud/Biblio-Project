<?php

// src/Controller/DisciplineController.php
namespace App\Controller;

use App\Entity\Discipline;
use App\Repository\DisciplineRepository;
use App\Repository\BookRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DisciplineController extends AbstractController
{
    #[Route('/discipline/{id}/books', name: 'discipline_books')]
    public function showBooks(int $id, DisciplineRepository $disciplineRepository, BookRepository $bookRepository): Response
    {
        // Fetch the discipline by ID
        $discipline = $disciplineRepository->find($id);

        if (!$discipline) {
            throw $this->createNotFoundException('Discipline not found');
        }

        // Fetch books belonging to this discipline
        $books = $bookRepository->findBy(['discipline' => $discipline]);

        // Render the books in a template
        return $this->render('discipline/books.html.twig', [
            'discipline' => $discipline,
            'books' => $books,
        ]);
    }
}
