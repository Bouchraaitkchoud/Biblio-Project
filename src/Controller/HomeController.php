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
        if ($user && in_array('ROLE_ADMIN', $user->getRoles())) {
            return $this->redirectToRoute('admin_dashboard');
        }

        $disciplines = $disciplineRepository->findAll();

        return $this->render('home/index.html.twig', [
            'disciplines' => $disciplines,
        ]);
    }
}


