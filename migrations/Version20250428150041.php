<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250428150041 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE book CHANGE quantity quantity INT NOT NULL');
        $this->addSql('ALTER TABLE exemplaire DROP FOREIGN KEY exemplaire_ibfk_2');
        $this->addSql('DROP INDEX barcode ON exemplaire');
        $this->addSql('DROP INDEX section_id ON exemplaire');
        $this->addSql('ALTER TABLE exemplaire ADD code VARCHAR(50) NOT NULL, ADD status VARCHAR(20) NOT NULL, ADD created_at DATETIME NOT NULL, DROP section_id, DROP barcode, DROP status_id, DROP location_id, DROP call_number, DROP acquisition_date, DROP return_date, DROP price, DROP comment, CHANGE book_id book_id INT NOT NULL');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_5EF83C9277153098 ON exemplaire (code)');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX book_id TO IDX_5EF83C9216A2B381');
        $this->addSql('ALTER TABLE publisher CHANGE comment comment LONGTEXT DEFAULT NULL');
        $this->addSql('ALTER TABLE book_publisher DROP FOREIGN KEY book_publisher_ibfk_1');
        $this->addSql('ALTER TABLE book_publisher DROP FOREIGN KEY book_publisher_ibfk_2');
        $this->addSql('DROP INDEX `primary` ON book_publisher');
        $this->addSql('ALTER TABLE book_publisher ADD CONSTRAINT FK_8E46C30040C86FCE FOREIGN KEY (publisher_id) REFERENCES publisher (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE book_publisher ADD CONSTRAINT FK_8E46C30016A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE book_publisher ADD PRIMARY KEY (publisher_id, book_id)');
        $this->addSql('ALTER TABLE book_publisher RENAME INDEX publisher_id TO IDX_8E46C30040C86FCE');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE book CHANGE quantity quantity INT DEFAULT 0 NOT NULL');
        $this->addSql('ALTER TABLE publisher CHANGE comment comment TEXT DEFAULT NULL');
        $this->addSql('DROP INDEX UNIQ_5EF83C9277153098 ON exemplaire');
        $this->addSql('ALTER TABLE exemplaire ADD section_id INT DEFAULT NULL, ADD barcode VARCHAR(255) DEFAULT NULL, ADD status_id INT DEFAULT NULL, ADD location_id INT DEFAULT NULL, ADD call_number VARCHAR(255) DEFAULT NULL, ADD acquisition_date DATE DEFAULT NULL, ADD return_date DATE DEFAULT NULL, ADD price VARCHAR(255) DEFAULT NULL, ADD comment TEXT DEFAULT NULL, DROP code, DROP status, DROP created_at, CHANGE book_id book_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE exemplaire ADD CONSTRAINT exemplaire_ibfk_2 FOREIGN KEY (section_id) REFERENCES section (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('CREATE UNIQUE INDEX barcode ON exemplaire (barcode)');
        $this->addSql('CREATE INDEX section_id ON exemplaire (section_id)');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX idx_5ef83c9216a2b381 TO book_id');
        $this->addSql('ALTER TABLE book_publisher DROP FOREIGN KEY FK_8E46C30040C86FCE');
        $this->addSql('ALTER TABLE book_publisher DROP FOREIGN KEY FK_8E46C30016A2B381');
        $this->addSql('DROP INDEX `PRIMARY` ON book_publisher');
        $this->addSql('ALTER TABLE book_publisher ADD CONSTRAINT book_publisher_ibfk_1 FOREIGN KEY (book_id) REFERENCES book (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE book_publisher ADD CONSTRAINT book_publisher_ibfk_2 FOREIGN KEY (publisher_id) REFERENCES publisher (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE book_publisher ADD PRIMARY KEY (book_id, publisher_id)');
        $this->addSql('ALTER TABLE book_publisher RENAME INDEX idx_8e46c30040c86fce TO publisher_id');
    }
}
