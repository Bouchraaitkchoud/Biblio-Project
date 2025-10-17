<?php

namespace App\Security;

use Symfony\Component\Security\Http\Authentication\AuthenticationSuccessHandlerInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\RouterInterface;

class LoginSuccessHandler implements AuthenticationSuccessHandlerInterface
{
    public function __construct(private RouterInterface $router) {}

    public function onAuthenticationSuccess(Request $request, TokenInterface $token): Response
    {
        $roles = $token->getUser()->getRoles();

        // If full admin, redirect to admin dashboard.
        if (in_array('ROLE_ADMIN', $roles, true)) {
            return new RedirectResponse($this->router->generate('admin_dashboard'));
        } 

        // For limited admin, check for specific privilege roles.
        if (in_array('ROLE_LIMITED_ADMIN', $roles, true)) {
            if (in_array('ROLE_GERER_AUTEURS', $roles, true)) {
                return new RedirectResponse($this->router->generate('admin_authors_index'));
            }
            if (in_array('ROLE_GERER_UTILISATEURS', $roles, true)) {
                return new RedirectResponse($this->router->generate('admin_users_index'));
            }
            if (in_array('ROLE_GERER_LIVRES', $roles, true)) {
                return new RedirectResponse($this->router->generate('admin_books_index'));
            }
          
            if (in_array('ROLE_GERER_RETOURS', $roles, true)) {
                return new RedirectResponse($this->router->generate('admin_returns_index'));
            
            }
            if (in_array('ROLE_GERER_EDITEURS', $roles, true)) {
                return new RedirectResponse($this->router->generate('admin_publishers_index'));
            }
            if (in_array('ROLE_GERER_DISCIPLINES', $roles, true)) {
                return new RedirectResponse($this->router->generate('admin_disciplines_index'));
            }
            if (in_array('ROLE_GERER_COMMANDES', $roles, true)) {
                return new RedirectResponse($this->router->generate('admin_orders_index'));
            }
        }

        // Fallback for limited admin or normal user.
        return new RedirectResponse($this->router->generate('homepage'));
    }
}