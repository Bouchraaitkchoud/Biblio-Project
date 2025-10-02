<?php

namespace App\Security;

use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\RedirectResponse;
use Symfony\Component\Routing\Generator\UrlGeneratorInterface;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Http\Authentication\AuthenticationSuccessHandlerInterface;
use Symfony\Component\Security\Http\Util\TargetPathTrait;

class LoginSuccessHandler implements AuthenticationSuccessHandlerInterface
{
    use TargetPathTrait;
    
    private $urlGenerator;

    public function __construct(UrlGeneratorInterface $urlGenerator)
    {
        $this->urlGenerator = $urlGenerator;
    }

    public function onAuthenticationSuccess(Request $request, TokenInterface $token): Response
    {
        // First, check if there's a saved target path from a previous request
        $targetPath = $this->getTargetPath($request->getSession(), 'main');
        
        // If there was a specific page the user was trying to access, go there
        if ($targetPath) {
            // Remove the saved path so it's not reused accidentally
            $this->removeTargetPath($request->getSession(), 'main');
            return new RedirectResponse($targetPath);
        }
        
        // For direct logins (where user went straight to login page)
        // redirect based on role
        $roles = $token->getRoleNames();
        if (in_array('ROLE_ADMIN', $roles)) {
            // Redirect admin to dashboard
            return new RedirectResponse($this->urlGenerator->generate('admin_dashboard'));
        } 
        
        // Default redirect for regular users
        return new RedirectResponse($this->urlGenerator->generate('home'));
    }
} 