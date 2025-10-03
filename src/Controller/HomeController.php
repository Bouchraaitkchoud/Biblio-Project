<?php

namespace App\Controller;

use App\Repository\DisciplineRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(DisciplineRepository $disciplineRepository): Response
    {
        $user = $this->getUser();
        // Only redirect admin to dashboard if they're accessing root directly
        // and not coming from admin dashboard (Main Site button)
        if ($user && in_array('ROLE_ADMIN', $user->getRoles())) {
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
    public function mainSite(DisciplineRepository $disciplineRepository): Response
    {
        // This route always shows the main site, even for admins
        $disciplines = $disciplineRepository->findBy([], ['name' => 'ASC']);

        return $this->render('home/index.html.twig', [
            'disciplines' => $disciplines,
        ]);
    }
}


