<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251002094619 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs

        // Create the new discipline table first
        $this->addSql('CREATE TABLE discipline (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');

        // Migrate data from domain and section to discipline
        $this->addSql('INSERT INTO discipline (name) SELECT name FROM domain');
        $this->addSql('INSERT INTO discipline (name) SELECT name FROM section');

        // Now, perform the schema alterations
        $this->addSql('ALTER TABLE book DROP FOREIGN KEY FK_CBE5A331D823E37A');
        $this->addSql('DROP TABLE section');
        $this->addSql('DROP TABLE domain');
        $this->addSql('DROP INDEX IDX_CBE5A331D823E37A ON book');
        $this->addSql('ALTER TABLE book CHANGE section_id discipline_id INT NOT NULL');

        // Manually update the discipline_id in the book table
        // This assumes a direct mapping is not possible and uses names to link.
        // We need to add a temporary column to store the old section name.
        $this->addSql('ALTER TABLE book ADD temp_section_name VARCHAR(255)');
        $this->addSql('UPDATE book b JOIN (SELECT id, name FROM discipline) d ON b.discipline_id = d.id SET b.temp_section_name = d.name');
        $this->addSql('UPDATE book b JOIN discipline d ON b.temp_section_name = d.name SET b.discipline_id = d.id');
        $this->addSql('ALTER TABLE book DROP COLUMN temp_section_name');
        
        $this->addSql('ALTER TABLE book ADD CONSTRAINT FK_CBE5A331A5522701 FOREIGN KEY (discipline_id) REFERENCES discipline (id)');
        $this->addSql('CREATE INDEX IDX_CBE5A331A5522701 ON book (discipline_id)');
        $this->addSql('ALTER TABLE exemplaire CHANGE section_id discipline_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE book_publisher RENAME INDEX fk_8e46c30016a2b381 TO IDX_8E46C30016A2B381');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE book DROP FOREIGN KEY FK_CBE5A331A5522701');
        $this->addSql('CREATE TABLE section (id INT AUTO_INCREMENT NOT NULL, domain_id INT NOT NULL, name VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, INDEX IDX_2D737AEF115F0EE5 (domain_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('CREATE TABLE domain (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE section ADD CONSTRAINT FK_2D737AEF115F0EE5 FOREIGN KEY (domain_id) REFERENCES domain (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('DROP TABLE discipline');
        $this->addSql('DROP INDEX IDX_CBE5A331A5522701 ON book');
        $this->addSql('ALTER TABLE book CHANGE discipline_id section_id INT NOT NULL');
        $this->addSql('ALTER TABLE book ADD CONSTRAINT FK_CBE5A331D823E37A FOREIGN KEY (section_id) REFERENCES section (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('CREATE INDEX IDX_CBE5A331D823E37A ON book (section_id)');
        $this->addSql('ALTER TABLE book_publisher RENAME INDEX idx_8e46c30016a2b381 TO FK_8E46C30016A2B381');
        $this->addSql('ALTER TABLE exemplaire CHANGE discipline_id section_id INT DEFAULT NULL');
    }
}
