<?php

namespace App\EventListener;

use Symfony\Component\EventDispatcher\EventSubscriberInterface;
use Symfony\Component\HttpKernel\Event\ExceptionEvent;
use Symfony\Component\HttpKernel\KernelEvents;
use Symfony\Component\Security\Core\Exception\AccessDeniedException;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\Routing\RouterInterface;
use Symfony\Component\Security\Core\Security;
use Symfony\Component\Security\Core\Authorization\AuthorizationCheckerInterface;

class AccessDeniedListener implements EventSubscriberInterface
{
    public function __construct(
        private RouterInterface $router,
        private AuthorizationCheckerInterface $authorizationChecker
    ) {}

    public static function getSubscribedEvents(): array
    {
        return [
            KernelEvents::EXCEPTION => ['onKernelException', 2],
        ];
    }

    public function onKernelException(ExceptionEvent $event): void
    {
        $exception = $event->getThrowable();

        // Only handle AccessDeniedException
        if (!$exception instanceof AccessDeniedException) {
            return;
        }

        // Get user roles
        $roles = [];
        if ($this->authorizationChecker->isGranted('IS_AUTHENTICATED_FULLY')) {
            // Any admin (full or limited) - redirect to dashboard
            if ($this->authorizationChecker->isGranted('ROLE_ADMIN') || $this->authorizationChecker->isGranted('ROLE_LIMITED_ADMIN')) {
                $response = new RedirectResponse($this->router->generate('admin_dashboard'));
                $event->setResponse($response);
                return;
            }

            // Regular user (lecteur) - redirect to home
            if ($this->authorizationChecker->isGranted('ROLE_USER')) {
                $response = new RedirectResponse('/');
                $event->setResponse($response);
                return;
            }
        }

        // Not authenticated - redirect to login
        $response = new RedirectResponse($this->router->generate('app_admin_login'));
        $event->setResponse($response);
    }
}
