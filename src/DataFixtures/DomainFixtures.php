<?php

// src/DataFixtures/DomainFixtures.php
namespace App\DataFixtures;

use App\Entity\Domain;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class DomainFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        $domains = [
            'Computer Science',
            'Mathematics',
            'Literature',
            'Physics',
        ];

        foreach ($domains as $domainName) {
            $domain = new Domain();
            $domain->setName($domainName);
            $manager->persist($domain);
        }

        $manager->flush();
    }
}