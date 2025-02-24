<?php

// src/Controller/SectionController.php
namespace App\Controller;

use App\Entity\Domain;
use App\Repository\SectionRepository;
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
   
}
