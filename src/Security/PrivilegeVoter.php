<?php

namespace App\Security;

use App\Entity\User;
use Symfony\Component\Security\Core\Authentication\Token\TokenInterface;
use Symfony\Component\Security\Core\Authorization\Voter\Voter;

class PrivilegeVoter extends Voter
{
    // We assume the attribute names will be in the format "PRIVILEGE_<NAME>"
    protected function supports(string $attribute, $subject): bool
    {
        return str_starts_with($attribute, 'PRIVILEGE_');
    }

    protected function voteOnAttribute(string $attribute, $subject, TokenInterface $token): bool
    {
        $user = $token->getUser();

        if (!$user instanceof User) {
            return false;
        }

        // Map PRIVILEGE_* constants to actual ROLE_* in User::getRoles()
        $mapping = [
            'PRIVILEGE_GERER_LES_AUTEURS'   => 'ROLE_GERER_AUTEURS',
            'PRIVILEGE_GERER_LES_UTILISATEURS' => 'ROLE_GERER_UTILISATEURS',
            'PRIVILEGE_GERER_LES_LECTEURS' => 'ROLE_GERER_LECTEURS',
            'PRIVILEGE_GERER_LES_LIVRES'     => 'ROLE_GERER_LIVRES',
            'PRIVILEGE_GERER_LES_RETOURS'    => 'ROLE_GERER_RETOURS',
            'PRIVILEGE_GERER_LES_EDITEURS'   => 'ROLE_GERER_EDITEURS',
            'PRIVILEGE_GERER_LES_DISCIPLINES'=> 'ROLE_GERER_DISCIPLINES',
            'PRIVILEGE_GERER_LES_COMMANDES'  => 'ROLE_GERER_COMMANDES'
        ];

        if (!isset($mapping[$attribute])) {
            return false;
        }

        $requiredRole = $mapping[$attribute];
        $userRoles = $user->getRoles();

        // Absolute admin (ROLE_ADMIN) has all permissions
        if (in_array('ROLE_ADMIN', $userRoles, true)) {
            return true;
        }

        return in_array($requiredRole, $userRoles, true);
    }
}