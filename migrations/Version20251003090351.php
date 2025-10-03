<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251003090351 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Convert book cover_image from BLOB to VARCHAR for file system storage';
    }

    public function up(Schema $schema): void
    {
        // First, create a backup table for BLOB data (optional, for safety)
        $this->addSql('CREATE TABLE book_cover_backup AS SELECT id, cover_image FROM book WHERE cover_image IS NOT NULL');
        
        // Change cover_image from BLOB to VARCHAR(255)
        $this->addSql('ALTER TABLE book CHANGE cover_image cover_image VARCHAR(255) DEFAULT NULL');
        
        // Clear the cover_image field since we're changing storage method
        $this->addSql('UPDATE book SET cover_image = NULL');
    }

    public function down(Schema $schema): void
    {
        // Restore BLOB column
        $this->addSql('ALTER TABLE book CHANGE cover_image cover_image LONGBLOB DEFAULT NULL');
        
        // Restore BLOB data from backup (if exists)
        $this->addSql('UPDATE book b JOIN book_cover_backup bcb ON b.id = bcb.id SET b.cover_image = bcb.cover_image');
        
        // Drop backup table
        $this->addSql('DROP TABLE IF EXISTS book_cover_backup');
    }
}
