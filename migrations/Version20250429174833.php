<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250429174833 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Fix foreign key constraints for exemplaire and book relationship';
    }

    public function up(Schema $schema): void
    {
        // Drop existing foreign key constraints
        $this->addSql('ALTER TABLE exemplaire DROP FOREIGN KEY exemplaire_ibfk_1');
        $this->addSql('ALTER TABLE exemplaire DROP FOREIGN KEY exemplaire_ibfk_2');
        
        // Drop existing indexes
        $this->addSql('DROP INDEX book_id ON exemplaire');
        $this->addSql('DROP INDEX section_id ON exemplaire');
        
        // Add new foreign key constraint with correct naming
        $this->addSql('ALTER TABLE exemplaire ADD CONSTRAINT FK_5EF83C9216A2B381 FOREIGN KEY (book_id) REFERENCES book (id)');
        $this->addSql('CREATE INDEX IDX_5EF83C9216A2B381 ON exemplaire (book_id)');
    }

    public function down(Schema $schema): void
    {
        // Restore original foreign key constraints
        $this->addSql('ALTER TABLE exemplaire DROP FOREIGN KEY FK_5EF83C9216A2B381');
        $this->addSql('DROP INDEX IDX_5EF83C9216A2B381 ON exemplaire');
        
        $this->addSql('ALTER TABLE exemplaire ADD CONSTRAINT exemplaire_ibfk_1 FOREIGN KEY (book_id) REFERENCES book (id)');
        $this->addSql('ALTER TABLE exemplaire ADD CONSTRAINT exemplaire_ibfk_2 FOREIGN KEY (section_id) REFERENCES section (id)');
        
        $this->addSql('CREATE INDEX book_id ON exemplaire (book_id)');
        $this->addSql('CREATE INDEX section_id ON exemplaire (section_id)');
    }
}
