<?php

namespace App\Security;

use Symfony\Component\Security\Http\Authentication\AuthenticationSuccessHandlerInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\Routing\RouterInterface;
use Symfony\Component\Routing\Exception\RouteNotFoundException;

class LoginSuccessHandler implements AuthenticationSuccessHandlerInterface
{
    public function __construct(private RouterInterface $router) {}

    public function onAuthenticationSuccess(Request $request, TokenInterface $token): Response
    {
        // Support both getRoleNames() (newer Symfony) and getRoles()
        $roles = method_exists($token, 'getRoleNames') ? $token->getRoleNames() : $token->getUser()->getRoles();

        // Admin-related roles (keep these as they are)
        $adminRoles = [
            'ROLE_ADMIN',
            'ROLE_LIMITED_ADMIN',
            'ROLE_GERER_AUTEURS',
            'ROLE_GERER_UTILISATEURS',
            'ROLE_GERER_LIVRES',
            'ROLE_GERER_RETOURS',
            'ROLE_GERER_EDITEURS',
            'ROLE_GERER_DISCIPLINES',
            'ROLE_GERER_COMMANDES',
        ];

        // If an admin accidentally logged in via lecteur form, send them to admin login
        // Detect lecteur login route by route name or path (adjust 'app_login' if different)
        $currentRoute = $request->attributes->get('_route', '');
        $isLecteurLoginRoute = in_array($currentRoute, ['app_login', 'lecteur_login'], true)
            || str_starts_with($request->getPathInfo(), '/login');

        if (!empty(array_intersect($roles, $adminRoles)) && $isLecteurLoginRoute) {
            $request->getSession()?->invalidate();
            return new RedirectResponse($this->router->generate('app_admin_login'));
        }

        // If full admin, redirect to admin dashboard.
        if (in_array('ROLE_ADMIN', $roles, true)) {
            return new RedirectResponse($this->router->generate('admin_dashboard'));
        }

        // For limited admin, check for specific privilege roles.
        if (in_array('ROLE_LIMITED_ADMIN', $roles, true) || !empty(array_intersect($roles, $adminRoles))) {
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

            // fallback for other admin roles
            return new RedirectResponse($this->router->generate('admin_dashboard'));
        }

        // Fallback for normal lecteur / user: redirect to site root
        // redirect to the site root ("/") as lecteur home
        return new RedirectResponse('/');
    }
}