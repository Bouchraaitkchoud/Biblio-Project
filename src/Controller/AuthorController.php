<?php

namespace App\Controller;

use App\Entity\Author;
use App\Repository\AuthorRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class AuthorController extends AbstractController
{
    #[Route('/author/{id}', name: 'author_show', methods: ['GET'])]
    public function show(Author $author): Response
    {
        // Block LIMITED_ADMIN from viewing author
        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Les administrateurs limités n\'ont pas accès au site principal.');
        }
        
        return $this->render('author/show.html.twig', [
            'author' => $author,
        ]);
    }
} 