<?php

namespace App\Controller\Admin;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

class LimitedAdminPanelController extends AbstractController
{
    #[Route('/admin/panel', name: 'admin_limited_panel')]
    #[IsGranted('ROLE_LIMITED_ADMIN')]
    public function index(): Response
    {
        return $this->render('admin/limited_admin_panel.html.twig');
    }
}
