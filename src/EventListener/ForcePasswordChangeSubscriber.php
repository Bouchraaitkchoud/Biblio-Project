<?php

namespace App\EventListener;

use App\Entity\Lecteur;
use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\HttpKernel\Event\RequestEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Core\Authentication\Token\Storage\TokenStorageInterface;

class ForcePasswordChangeSubscriber implements EventSubscriberInterface
{
    public function __construct(
        private TokenStorageInterface $tokenStorage,
        private UrlGeneratorInterface $urlGenerator
    ) {}

    public static function getSubscribedEvents(): array
    {
        return [
            KernelEvents::REQUEST => ['onKernelRequest', 7],
        ];
    }

    public function onKernelRequest(RequestEvent $event): void
    {
        if (!$event->isMainRequest()) {
            return;
        }

        $request = $event->getRequest();
        $route = $request->attributes->get('_route');

        // Skip check for logout, password change, and assets routes
        if (in_array($route, ['app_logout', 'profile_change_password']) 
            || str_starts_with($route, '_')
            || str_starts_with($request->getPathInfo(), '/assets/')
            || str_starts_with($request->getPathInfo(), '/css/')
            || str_starts_with($request->getPathInfo(), '/js/')
            || str_starts_with($request->getPathInfo(), '/images/')
        ) {
            return;
        }

        $token = $this->tokenStorage->getToken();
        if (!$token) {
            return;
        }

        $user = $token->getUser();
        
        // Debug: Log user info
        error_log("DEBUG ForcePasswordChange - User: " . ($user ? get_class($user) : 'null'));
        if ($user instanceof Lecteur) {
            error_log("DEBUG ForcePasswordChange - Is Lecteur: YES");
            error_log("DEBUG ForcePasswordChange - Force change: " . ($user->getForcePasswordChange() ? 'YES' : 'NO'));
        }
        
        // Only check for Lecteur entities (not Admin users)
        if ($user instanceof Lecteur && $user->getForcePasswordChange()) {
            error_log("DEBUG ForcePasswordChange - REDIRECTING to change password");
            $session = $request->getSession();
            
            // Add flash message only once
            if (!$session->has('password_change_warning_shown')) {
                $session->getFlashBag()->add(
                    'warning',
                    'Vous devez changer votre mot de passe avant de continuer.'
                );
                $session->set('password_change_warning_shown', true);
            }
            
            $url = $this->urlGenerator->generate('profile_change_password');
            $event->setResponse(new RedirectResponse($url));
        }
    }
}
