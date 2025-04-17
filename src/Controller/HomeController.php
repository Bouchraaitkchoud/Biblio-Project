<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class HomeController extends AbstractController
{
    #[Route('/', name: 'home')]
    public function index(): Response
    {
        // Get the current user
        $user = $this->getUser();
        
        // If user is logged in, redirect based on role
        if ($user) {
            if (in_array('ROLE_ADMIN', $user->getRoles())) {
                // Redirect admin to dashboard
                return $this->redirectToRoute('admin_dashboard');
            } else {
                // Redirect regular users to domains page
                return $this->redirectToRoute('app_domains');
            }
        }
        
        // For non-authenticated users, redirect to login
        return $this->redirectToRoute('app_login');
    }
}

