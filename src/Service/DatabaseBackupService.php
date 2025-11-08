<?php

namespace App\Service;

use Doctrine\DBAL\Connection;
use Symfony\Component\Filesystem\Filesystem;
use Symfony\Component\DependencyInjection\ParameterBag\ParameterBagInterface;

class DatabaseBackupService
{
    private string $projectDir;
    private Connection $connection;
    private Filesystem $filesystem;

    public function __construct(
        ParameterBagInterface $params,
        Connection $connection
    ) {
        $this->projectDir = $params->get('kernel.project_dir');
        $this->connection = $connection;
        $this->filesystem = new Filesystem();
    }

    /**
     * Calculate academic year based on current date
     * Academic year starts in September (month 9)
     */
    public function calculateAcademicYear(): string
    {
        $currentDate = new \DateTime();
        $currentMonth = (int) $currentDate->format('m');
        $currentYear = (int) $currentDate->format('Y');

        // If September or later, academic year is current_year - next_year
        // If before September, academic year is previous_year - current_year
        if ($currentMonth >= 9) {
            return $currentYear . '_' . ($currentYear + 1);
        } else {
            return ($currentYear - 1) . '_' . $currentYear;
        }
    }

    /**
     * Generate backup filename with academic year and timestamp
     */
    public function generateBackupFilename(): string
    {
        $academicYear = $this->calculateAcademicYear();
        $timestamp = date('Y-m-d_H-i-s');
        return "biblio_backup_{$academicYear}_{$timestamp}.sql";
    }

    /**
     * Get backup directory path
     */
    public function getBackupDirectory(): string
    {
        $backupDir = $this->projectDir . '/var/backups';
        
        // Create directory if it doesn't exist
        if (!$this->filesystem->exists($backupDir)) {
            $this->filesystem->mkdir($backupDir, 0755);
        }
        
        return $backupDir;
    }

    /**
     * Create database backup using native PHP/MySQL queries
     */
    public function createBackup(): array
    {
        try {
            // Generate filename and path
            $filename = $this->generateBackupFilename();
            $backupPath = $this->getBackupDirectory() . '/' . $filename;

            // Get database name
            $params = $this->connection->getParams();
            $dbName = $params['dbname'] ?? '';

            // Start building SQL content
            $sqlContent = "-- Database Backup: {$dbName}\n";
            $sqlContent .= "-- Created: " . date('Y-m-d H:i:s') . "\n";
            $sqlContent .= "-- Academic Year: " . $this->calculateAcademicYear() . "\n\n";
            $sqlContent .= "SET FOREIGN_KEY_CHECKS=0;\n\n";

            // Get all tables
            $tables = $this->connection->fetchFirstColumn('SHOW TABLES');

            foreach ($tables as $table) {
                // Get CREATE TABLE statement
                $createTableResult = $this->connection->fetchAssociative("SHOW CREATE TABLE `{$table}`");
                $createTable = $createTableResult['Create Table'] ?? '';
                
                $sqlContent .= "-- Table: {$table}\n";
                $sqlContent .= "DROP TABLE IF EXISTS `{$table}`;\n";
                $sqlContent .= $createTable . ";\n\n";

                // Get table data
                $rows = $this->connection->fetchAllAssociative("SELECT * FROM `{$table}`");
                
                if (!empty($rows)) {
                    $sqlContent .= "-- Data for table {$table}\n";
                    
                    foreach ($rows as $row) {
                        $values = [];
                        foreach ($row as $value) {
                            if ($value === null) {
                                $values[] = 'NULL';
                            } else {
                                $values[] = "'" . $this->connection->quote($value) . "'";
                            }
                        }
                        
                        $columns = array_keys($row);
                        $columnsStr = '`' . implode('`, `', $columns) . '`';
                        $valuesStr = implode(', ', $values);
                        
                        $sqlContent .= "INSERT INTO `{$table}` ({$columnsStr}) VALUES ({$valuesStr});\n";
                    }
                    
                    $sqlContent .= "\n";
                }
            }

            $sqlContent .= "SET FOREIGN_KEY_CHECKS=1;\n";

            // Write to file
            $this->filesystem->dumpFile($backupPath, $sqlContent);

            $fileSize = filesize($backupPath);
            $fileSizeMB = round($fileSize / 1024 / 1024, 2);

            return [
                'success' => true,
                'filename' => $filename,
                'path' => $backupPath,
                'size' => $fileSizeMB . ' MB',
                'academicYear' => $this->calculateAcademicYear(),
                'timestamp' => date('Y-m-d H:i:s')
            ];

        } catch (\Exception $e) {
            return [
                'success' => false,
                'error' => $e->getMessage()
            ];
        }
    }

    /**
     * Clean student data (lecteurs and their orders)
     */
    public function cleanStudentData(): array
    {
        try {
            $conn = $this->connection;

            // Get list of existing tables
            $existingTables = $conn->fetchFirstColumn('SHOW TABLES');

            // Count records before deletion (for reporting)
            $lecteurCount = $conn->fetchOne('SELECT COUNT(*) FROM lecteur');
            $orderCount = $conn->fetchOne('SELECT COUNT(*) FROM orders');
            $orderItemCount = $conn->fetchOne('SELECT COUNT(*) FROM order_item');
            
            // Initialize counts
            $receiptCount = 0;
            $cartCount = 0;
            $cartItemCount = 0;

            // Temporarily disable foreign key checks for easier deletion
            $conn->executeStatement('SET FOREIGN_KEY_CHECKS=0');

            // Delete in correct order to respect foreign key constraints:
            
            // 1. cart_item (if exists - depends on cart)
            if (in_array('cart_item', $existingTables)) {
                $cartItemCount = $conn->fetchOne('SELECT COUNT(*) FROM cart_item');
                $conn->executeStatement('DELETE FROM cart_item');
            }

            // 2. order_item (depends on orders)
            $conn->executeStatement('DELETE FROM order_item');

            // 3. receipt (if exists)
            if (in_array('receipt', $existingTables)) {
                $receiptCount = $conn->fetchOne('SELECT COUNT(*) FROM receipt');
                $conn->executeStatement('DELETE FROM receipt');
            }

            // 4. cart (if exists - depends on lecteur)
            if (in_array('cart', $existingTables)) {
                $cartCount = $conn->fetchOne('SELECT COUNT(*) FROM cart');
                $conn->executeStatement('DELETE FROM cart');
            }

            // 5. orders (depends on lecteur)
            $conn->executeStatement('DELETE FROM orders');

            // 6. lecteur (can now be safely deleted)
            $conn->executeStatement('DELETE FROM lecteur');

            // Reset auto-increment counters for existing tables
            $conn->executeStatement('ALTER TABLE lecteur AUTO_INCREMENT = 1');
            $conn->executeStatement('ALTER TABLE orders AUTO_INCREMENT = 1');
            $conn->executeStatement('ALTER TABLE order_item AUTO_INCREMENT = 1');
            
            if (in_array('receipt', $existingTables)) {
                $conn->executeStatement('ALTER TABLE receipt AUTO_INCREMENT = 1');
            }
            if (in_array('cart', $existingTables)) {
                $conn->executeStatement('ALTER TABLE cart AUTO_INCREMENT = 1');
            }
            if (in_array('cart_item', $existingTables)) {
                $conn->executeStatement('ALTER TABLE cart_item AUTO_INCREMENT = 1');
            }

            // Re-enable foreign key checks
            $conn->executeStatement('SET FOREIGN_KEY_CHECKS=1');

            return [
                'success' => true,
                'deleted' => [
                    'lecteurs' => $lecteurCount,
                    'orders' => $orderCount,
                    'orderItems' => $orderItemCount,
                    'receipts' => $receiptCount,
                    'carts' => $cartCount,
                    'cartItems' => $cartItemCount
                ]
            ];

        } catch (\Exception $e) {
            // Re-enable foreign key checks even on error
            try {
                $conn->executeStatement('SET FOREIGN_KEY_CHECKS=1');
            } catch (\Exception $ignored) {
                // Ignore if this fails
            }

            return [
                'success' => false,
                'error' => $e->getMessage()
            ];
        }
    }

    /**
     * List all backup files
     */
    public function listBackups(): array
    {
        $backupDir = $this->getBackupDirectory();
        $backups = [];

        if (!is_dir($backupDir)) {
            return $backups;
        }

        $files = scandir($backupDir, SCANDIR_SORT_DESCENDING); // Newest first

        foreach ($files as $file) {
            if ($file === '.' || $file === '..') {
                continue;
            }

            $filePath = $backupDir . '/' . $file;
            
            if (is_file($filePath) && pathinfo($file, PATHINFO_EXTENSION) === 'sql') {
                $backups[] = [
                    'filename' => $file,
                    'size' => round(filesize($filePath) / 1024 / 1024, 2) . ' MB',
                    'created' => date('Y-m-d H:i:s', filemtime($filePath)),
                    'path' => $filePath
                ];
            }
        }

        return $backups;
    }

    /**
     * Delete a backup file
     */
    public function deleteBackup(string $filename): bool
    {
        $backupPath = $this->getBackupDirectory() . '/' . $filename;
        
        if ($this->filesystem->exists($backupPath)) {
            $this->filesystem->remove($backupPath);
            return true;
        }
        
        return false;
    }

    /**
     * Get backup file path for download
     */
    public function getBackupPath(string $filename): ?string
    {
        $backupPath = $this->getBackupDirectory() . '/' . $filename;
        
        if ($this->filesystem->exists($backupPath)) {
            return $backupPath;
        }
        
        return null;
    }
}
