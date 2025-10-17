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

        // Map the attribute to the actual privilege label stored in User::getPrivileges()
        $mapping = [
            'PRIVILEGE_GERER_LES_AUTEURS'   => 'Gérer les auteurs',
            'PRIVILEGE_GERER_LES_UTILISATEURS' => 'Gérer les utilisateurs',
            'PRIVILEGE_GERER_LES_LIVRES'     => 'Gérer les livres',
    
            'PRIVILEGE_GERER_LES_RETOURS'    => 'Gérer les retours',
            
            'PRIVILEGE_GERER_LES_EDITEURS'   => 'Gérer les éditeurs',
            'PRIVILEGE_GERER_LES_DISCIPLINES'=> 'Gérer les disciplines',
            'PRIVILEGE_GERER_LES_COMMANDES'  => 'Gérer les commandes'
        

        ];

        if (!isset($mapping[$attribute])) {
            return false;
        }

        $requiredPrivilege = $mapping[$attribute];
        $userPrivileges = $user->getPrivileges();

        return in_array($requiredPrivilege, $userPrivileges, true);
    }
}