<?php

namespace App\DataFixtures;

use App\Entity\User;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;

class UserFixtures extends Fixture
{
    public function __construct(
        private UserPasswordHasherInterface $passwordHasher
    ) {}

    public function load(ObjectManager $manager): void
    {
        // Create regular user
        $user = new User();
        $user->setEmail('user@example.com');
        $user->setPassword($this->passwordHasher->hashPassword(
            $user, 
            'password' // Consider using more secure default password
        ));
        // ROLE_USER is automatically added by your User::getRoles() method
        $user->setRoles([]); 
        
        $manager->persist($user);

        // Create admin user
        $admin = new User();
        $admin->setEmail('admin@example.com');
        $admin->setPassword($this->passwordHasher->hashPassword(
            $admin,
            'admin123' // Consider using more secure default password
        ));
        $admin->setRoles(['ROLE_ADMIN']);
        
        $manager->persist($admin);
        
        // Single flush at the end (more efficient)
        $manager->flush();
    }
}