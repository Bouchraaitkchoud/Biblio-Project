<?php

namespace App\Controller;

use App\Entity\Publisher;
use App\Repository\PublisherRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class PublisherController extends AbstractController
{
    #[Route('/publisher/{id}', name: 'publisher_show', methods: ['GET'])]
    public function show(Publisher $publisher): Response
    {
        return $this->render('publisher/show.html.twig', [
            'publisher' => $publisher,
        ]);
    }
}