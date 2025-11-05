<?php

namespace App\Controller;

use App\Repository\DisciplineRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function index(DisciplineRepository $disciplineRepository): Response
    {
        // Block LIMITED_ADMIN from accessing the main site
        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Les administrateurs limités n\'ont pas accès au site principal.');
        }
        
        $user = $this->getUser();
        
        // Only redirect ROLE_ADMIN (not LIMITED_ADMIN) to dashboard if they're accessing root directly
        // and not coming from admin dashboard (Main Site button)
        if ($user && $this->isGranted('ROLE_ADMIN')) {
            $referer = $_SERVER['HTTP_REFERER'] ?? '';
            // If not coming from admin area, redirect to admin dashboard
            if (!str_contains($referer, '/admin/')) {
                return $this->redirectToRoute('admin_dashboard');
            }
        }

        $disciplines = $disciplineRepository->findBy([], ['name' => 'ASC']);

        return $this->render('home/index.html.twig', [
            'disciplines' => $disciplines,
        ]);
    }

    #[Route('/main-site', name: 'main_site')]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function mainSite(DisciplineRepository $disciplineRepository): Response
    {
        // Block LIMITED_ADMIN from accessing the main site
        if ($this->isGranted('ROLE_LIMITED_ADMIN') && !$this->isGranted('ROLE_ADMIN')) {
            throw $this->createAccessDeniedException('Les administrateurs limités n\'ont pas accès au site principal.');
        }
        
        // This route allows ROLE_ADMIN (full admin) and ROLE_USER (Lecteurs) to access
        // ROLE_LIMITED_ADMIN is blocked by access_control
        $disciplines = $disciplineRepository->findBy([], ['name' => 'ASC']);

        return $this->render('home/index.html.twig', [
            'disciplines' => $disciplines,
            'show_admin_link' => $this->isGranted('ROLE_ADMIN'), // Show link back to admin panel
        ]);
    }
}


