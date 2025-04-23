<?php

namespace App\Command;

use Symfony\Component\Console\Attribute\AsCommand;
use Symfony\Component\Console\Command\Command;
use Symfony\Component\Console\Input\InputArgument;
use Symfony\Component\Console\Input\InputInterface;
use Symfony\Component\Console\Output\OutputInterface;
use Symfony\Component\Console\Style\SymfonyStyle;
use Doctrine\DBAL\Connection;

#[AsCommand(
    name: 'app:database:search',
    description: 'Search for a string across all database tables',
)]
class DatabaseSearchCommand extends Command
{
    private Connection $connection;

    public function __construct(Connection $connection)
    {
        parent::__construct();
        $this->connection = $connection;
    }

    protected function configure(): void
    {
        $this
            ->addArgument('search', InputArgument::REQUIRED, 'The string to search for')
            ->addArgument('limit', InputArgument::OPTIONAL, 'Limit results per table', 10);
    }

    protected function execute(InputInterface $input, OutputInterface $output): int
    {
        $io = new SymfonyStyle($input, $output);
        $searchString = $input->getArgument('search');
        $limit = (int) $input->getArgument('limit');

        $io->title(sprintf('Searching for "%s" across all tables', $searchString));

        // Get all tables
        $tables = $this->connection->createSchemaManager()->listTableNames();
        
        $results = [];
        $totalMatches = 0;

        foreach ($tables as $table) {
            // Get all columns for this table
            $columns = $this->connection->createSchemaManager()->listTableColumns($table);
            
            foreach ($columns as $column) {
                $columnName = $column->getName();
                $columnType = $column->getType()->getName();
                
                // Only search string-type columns
                if (in_array($columnType, ['string', 'text', 'guid', 'json'])) {
                    $query = "SELECT * FROM `$table` WHERE `$columnName` LIKE :search LIMIT :limit";
                    $stmt = $this->connection->executeQuery(
                        $query, 
                        ['search' => '%' . $searchString . '%', 'limit' => $limit]
                    );
                    
                    $matches = $stmt->fetchAllAssociative();
                    $matchCount = count($matches);
                    
                    if ($matchCount > 0) {
                        $results[] = [
                            'table' => $table,
                            'column' => $columnName,
                            'matches' => $matchCount,
                            'data' => $matches
                        ];
                        
                        $totalMatches += $matchCount;
                    }
                }
            }
        }

        if (empty($results)) {
            $io->warning('No matches found');
            return Command::SUCCESS;
        }

        $io->success(sprintf('Found %d matches in %d table columns', $totalMatches, count($results)));
        
        foreach ($results as $result) {
            $io->section(sprintf('%s.%s - %d matches', $result['table'], $result['column'], $result['matches']));
            $io->table(
                array_keys($result['data'][0]),
                array_map(function ($row) {
                    return array_map(function ($value) {
                        return is_string($value) ? (strlen($value) > 50 ? substr($value, 0, 50) . '...' : $value) : $value;
                    }, $row);
                }, $result['data'])
            );
        }

        return Command::SUCCESS;
    }
} 