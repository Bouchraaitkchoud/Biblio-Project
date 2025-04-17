<?php

namespace App\DataFixtures;

use App\Entity\Author;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class AuthorFixtures extends Fixture
{
    public const AUTHOR_REFERENCE_PREFIX = 'author-';
    
    public function load(ObjectManager $manager): void
    {
        $authors = [
            'Donald Knuth' => 'Computer scientist and mathematician known for "The Art of Computer Programming".',
            'Robert C. Martin' => 'Software engineer and author known for promoting clean code practices.',
            'Martin Fowler' => 'Software developer and author focused on object-oriented analysis and design.',
            'Tim Berners-Lee' => 'Computer scientist best known as the inventor of the World Wide Web.',
            'Linus Torvalds' => 'Software engineer known for creating the Linux kernel and Git.',
        ];
        
        $i = 0;
        foreach ($authors as $name => $bio) {
            $author = new Author();
            $author->setName($name);
            $author->setBio($bio);
            
            $manager->persist($author);
            
            // Add reference for use in other fixtures
            $this->addReference(self::AUTHOR_REFERENCE_PREFIX . $i, $author);
            $i++;
        }
        
        $manager->flush();
    }
} 