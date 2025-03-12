<?php

// src/Controller/SectionController.php
namespace App\Controller;

use App\Entity\Domain;
use App\Repository\SectionRepository;
use App\Repository\BookRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class SectionController extends AbstractController
{
    #[Route('/domain/{id}/sections', name: 'app_sections')]
    public function index(Domain $domain, SectionRepository $sectionRepository): Response
    {
        $sections = $sectionRepository->findBy(['domain' => $domain]);
        return $this->render('section/index.html.twig', [
            'sections' => $sections,
            'domain' => $domain,
        ]);
    }
    #[Route('/section/{id}/books', name: 'section_books')]
    public function showBooks(int $id, SectionRepository $sectionRepository, BookRepository $bookRepository): Response
    {
        // Fetch the section by ID
        $section = $sectionRepository->find($id);

        if (!$section) {
            throw $this->createNotFoundException('Section not found');
        }

        // Fetch books belonging to this section
        $books = $bookRepository->findBy(['section' => $section]);

        // Render the books in a template
        return $this->render('section/books.html.twig', [
            'section' => $section,
            'books' => $books,
        ]);
    }
   
}
