<?php
// src/DataFixtures/BookFixture.php
namespace App\DataFixtures;

use App\Entity\Domain;
use App\Entity\Section;
use App\Entity\Book;
use Doctrine\Bundle\FixturesBundle\Fixture;
use Doctrine\Persistence\ObjectManager;

class BookFixture extends Fixture
{
    public function load(ObjectManager $manager): void
    {
        // Create the "Computer Science" domain
        $domain = new Domain();
        $domain->setName('Computer Science');
        $manager->persist($domain);

        // Create sections under the "Computer Science" domain
        $sections = [
            'Programming' => [
                ['title' => 'Clean Code: A Handbook of Agile Software Craftsmanship', 'author' => 'Robert C. Martin'],
                ['title' => 'The Pragmatic Programmer: Your Journey to Mastery', 'author' => 'Andrew Hunt, David Thomas'],
            ],
            'Networking' => [
                ['title' => 'Computer Networking: A Top-Down Approach', 'author' => 'James F. Kurose, Keith W. Ross'],
                ['title' => 'TCP/IP Illustrated, Volume 1: The Protocols', 'author' => 'W. Richard Stevens'],
            ],
            'Databases' => [
                ['title' => 'Database System Concepts', 'author' => 'Abraham Silberschatz, Henry F. Korth, S. Sudarshan'],
                ['title' => 'SQL in 10 Minutes, Sams Teach Yourself', 'author' => 'Ben Forta'],
            ],
            'Artificial Intelligence' => [
                ['title' => 'Artificial Intelligence: A Modern Approach', 'author' => 'Stuart Russell, Peter Norvig'],
                ['title' => 'Deep Learning', 'author' => 'Ian Goodfellow, Yoshua Bengio, Aaron Courville'],
            ],
        ];

        foreach ($sections as $sectionName => $booksData) {
            // Create a section
            $section = new Section();
            $section->setName($sectionName);
            $section->setDomain($domain); // Associate the section with the domain
            $manager->persist($section);

            // Add books to the section
            foreach ($booksData as $bookData) {
                $book = new Book();
                $book->setTitle($bookData['title']);
                $book->setAuthor($bookData['author']);
                $book->setSection($section); // Associate the book with the section
                $manager->persist($book);
            }
        }

        // Save all changes
        $manager->flush();
    }
}