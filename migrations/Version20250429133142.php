<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250429133142 extends AbstractMigration
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
        $this->addSql('DROP INDEX section_id ON exemplaire');
        $this->addSql('ALTER TABLE exemplaire ADD status VARCHAR(20) NOT NULL, DROP status_id, CHANGE book_id book_id INT NOT NULL, CHANGE barcode barcode VARCHAR(50) NOT NULL, CHANGE call_number call_number VARCHAR(50) DEFAULT NULL, CHANGE price price NUMERIC(10, 2) DEFAULT NULL, CHANGE comment comment VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX barcode TO UNIQ_5EF83C9297AE0266');
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
        $this->addSql('ALTER TABLE exemplaire ADD status_id INT DEFAULT NULL, DROP status, CHANGE book_id book_id INT DEFAULT NULL, CHANGE barcode barcode VARCHAR(255) DEFAULT NULL, CHANGE call_number call_number VARCHAR(255) DEFAULT NULL, CHANGE price price VARCHAR(255) DEFAULT NULL, CHANGE comment comment TEXT DEFAULT NULL');
        $this->addSql('ALTER TABLE exemplaire ADD CONSTRAINT exemplaire_ibfk_2 FOREIGN KEY (section_id) REFERENCES section (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('CREATE INDEX section_id ON exemplaire (section_id)');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX uniq_5ef83c9297ae0266 TO barcode');
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
