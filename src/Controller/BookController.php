<?php

// src/Controller/BookController.php
namespace App\Controller;

use App\Entity\Book;
use App\Repository\BookRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class BookController extends AbstractController
{
    private $bookRepository;
    
    public function __construct(BookRepository $bookRepository)
    {
        $this->bookRepository = $bookRepository;
    }
    
    #[Route('/book/{id}', name: 'book_show', methods: ['GET'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function show(Book $book): Response
    {
        // Block LIMITED_ADMIN from accessing books
        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Les administrateurs limités n\'ont pas accès au site principal.');
        }
        
        return $this->render('book/show.html.twig', [
            'book' => $book,
        ]);
    }
    
}
