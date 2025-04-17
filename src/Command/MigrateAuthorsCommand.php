<?php

namespace App\Command;

use App\Entity\Author;
use App\Entity\Book;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;

#[AsCommand(
    name: 'app:migrate-authors',
    description: 'Migrates existing book author strings to Author entities',
)]
class MigrateAuthorsCommand extends Command
{
    private EntityManagerInterface $entityManager;

    public function __construct(EntityManagerInterface $entityManager)
    {
        parent::__construct();
        $this->entityManager = $entityManager;
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $io->title('Migrating Book Authors to Author Entities with ManyToMany Relationship');

        // Get all books
        $bookRepository = $this->entityManager->getRepository(Book::class);
        $books = $bookRepository->findAll();

        // Track authors to avoid duplicates
        $authorMap = [];
        $authorRepository = $this->entityManager->getRepository(Author::class);
        
        $io->progressStart(count($books));
        
        // Process each book
        foreach ($books as $book) {
            // Get author name from temp field or existing relationship
            $authorString = $book->getAuthorName();
            if (empty($authorString)) {
                $io->progressAdvance();
                continue;
            }
            
            // Multiple authors might be separated by a comma
            $authorNames = array_map('trim', explode(',', $authorString));
            
            foreach ($authorNames as $authorName) {
                // Skip empty names
                if (empty($authorName)) {
                    continue;
                }
                
                // Check if we've already processed this author
                if (!isset($authorMap[$authorName])) {
                    // Check if author already exists in database
                    $author = $authorRepository->findOneBy(['name' => $authorName]);
                    
                    if (!$author) {
                        // Create new author
                        $author = new Author();
                        $author->setName($authorName);
                        $this->entityManager->persist($author);
                    }
                    
                    $authorMap[$authorName] = $author;
                }
                
                // Associate book with author using the ManyToMany relationship
                $book->addAuthor($authorMap[$authorName]);
            }
            
            $io->progressAdvance();
        }
        
        // Save changes
        $this->entityManager->flush();
        
        $io->progressFinish();
        $io->success('Successfully migrated ' . count($authorMap) . ' authors from ' . count($books) . ' books.');

        return Command::SUCCESS;
    }
} 