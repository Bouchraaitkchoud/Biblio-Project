<?php

// src/Controller/BookController.php
namespace App\Controller;

use App\Entity\Section;
use App\Repository\BookRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class BookController extends AbstractController
{
    #[Route('/section/{id}/books', name: 'app_books')]
    public function index(Section $section, BookRepository $bookRepository): Response
    {
        $books = $bookRepository->findBy(['section' => $section]);

        return $this->render('book/index.html.twig', [
            'books' => $books,
            'section' => $section,
        ]);
    }
}
