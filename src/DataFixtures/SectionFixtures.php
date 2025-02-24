<?php

// src/DataFixtures/SectionFixtures.php
namespace App\DataFixtures;

use App\Entity\Domain;
use App\Entity\Section;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class SectionFixtures extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // Fetch the domain (e.g., Computer Science)
        $domain = $manager->getRepository(Domain::class)->findOneBy(['name' => 'Computer Science']);

        if ($domain) {
            $sections = [
                'Programming',
                'Networking',
                'Databases',
                'Artificial Intelligence',
            ];

            foreach ($sections as $sectionName) {
                $section = new Section();
                $section->setName($sectionName);
                $section->setDomain($domain); // Associate the section with the domain
                $manager->persist($section);
            }

            $manager->flush();
        }
    }
}
