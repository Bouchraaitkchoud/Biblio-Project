<?php
// src/DataFixtures/BookFixture.php
namespace App\DataFixtures;

use App\Entity\Book;
use App\Entity\Section;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Common\DataFixtures\DependentFixtureInterface;
use Doctrine\Persistence\ObjectManager;

class BookFixture extends Fixture implements DependentFixtureInterface
{
    public function load(ObjectManager $manager): void
    {
        // Load books for the Programming section
        $programmingSection = $manager->getRepository(Section::class)->findOneBy(['name' => 'Programming']);
        
        if ($programmingSection) {
            $book1 = new Book();
            $book1->setTitle('The Art of Computer Programming');
            $book1->addAuthor($this->getReference(AuthorFixtures::AUTHOR_REFERENCE_PREFIX . '0')); // Donald Knuth
            $book1->setSection($programmingSection);
            
            // Set cover image from file if exists
            $coverPath = 'uploads/book_covers/art_of_computer_programming.jpg';
            if (file_exists($coverPath)) {
                $book1->setCoverImage(file_get_contents($coverPath));
            }
            
            $book1->setDescription('Comprehensive monograph written by Donald Knuth covering many kinds of programming algorithms and their analysis.');
            $book1->setPublicationYear(1968);
            $book1->setIsbn('978-0201896834');
            $manager->persist($book1);
            
            $book2 = new Book();
            $book2->setTitle('Clean Code');
            $book2->addAuthor($this->getReference(AuthorFixtures::AUTHOR_REFERENCE_PREFIX . '1')); // Robert C. Martin
            $book2->setSection($programmingSection);
            
            // Set cover image from file if exists
            $coverPath = 'uploads/book_covers/clean_code.jpg';
            if (file_exists($coverPath)) {
                $book2->setCoverImage(file_get_contents($coverPath));
            }
            
            $book2->setDescription('A handbook of agile software craftsmanship by Robert C. Martin that helps define what good code looks like.');
            $book2->setPublicationYear(2008);
            $book2->setIsbn('978-0132350884');
            $manager->persist($book2);
        }
        
        // Load books for the Database section
        $databaseSection = $manager->getRepository(Section::class)->findOneBy(['name' => 'Databases']);
        
        if ($databaseSection) {
            $book3 = new Book();
            $book3->setTitle('Patterns of Enterprise Application Architecture');
            $book3->addAuthor($this->getReference(AuthorFixtures::AUTHOR_REFERENCE_PREFIX . '2')); // Martin Fowler
            $book3->setSection($databaseSection);
            
            // Set cover image from file if exists
            $coverPath = 'uploads/book_covers/patterns_enterprise_architecture.jpg';
            if (file_exists($coverPath)) {
                $book3->setCoverImage(file_get_contents($coverPath));
            }
            
            $book3->setDescription('Martin Fowler\'s guide to the design of enterprise applications, with solutions to common problems.');
            $book3->setPublicationYear(2002);
            $book3->setIsbn('978-0321127426');
            $manager->persist($book3);
        }
        
        $manager->flush();
    }
    
    public function getDependencies(): array
    {
        return [
            SectionFixtures::class,
            AuthorFixtures::class,
        ];
    }
}