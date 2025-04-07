<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250304134142 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE borrowing_request_book (borrowing_request_id INT NOT NULL, book_id INT NOT NULL, INDEX IDX_F47A21D6542855AB (borrowing_request_id), INDEX IDX_F47A21D616A2B381 (book_id), PRIMARY KEY(borrowing_request_id, book_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE cart_book (cart_id INT NOT NULL, book_id INT NOT NULL, INDEX IDX_2400A3081AD5CDBF (cart_id), INDEX IDX_2400A30816A2B381 (book_id), PRIMARY KEY(cart_id, book_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE borrowing_request_book ADD CONSTRAINT FK_F47A21D6542855AB FOREIGN KEY (borrowing_request_id) REFERENCES borrowing_request (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE borrowing_request_book ADD CONSTRAINT FK_F47A21D616A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE cart_book ADD CONSTRAINT FK_2400A3081AD5CDBF FOREIGN KEY (cart_id) REFERENCES cart (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE cart_book ADD CONSTRAINT FK_2400A30816A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE borrowing_request ADD student_id INT NOT NULL, ADD status VARCHAR(255) NOT NULL');
        $this->addSql('ALTER TABLE borrowing_request ADD CONSTRAINT FK_F35F6694CB944F1A FOREIGN KEY (student_id) REFERENCES `user` (id)');
        $this->addSql('CREATE INDEX IDX_F35F6694CB944F1A ON borrowing_request (student_id)');
        $this->addSql('ALTER TABLE cart ADD student_id INT NOT NULL');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT FK_BA388B7CB944F1A FOREIGN KEY (student_id) REFERENCES `user` (id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_BA388B7CB944F1A ON cart (student_id)');
        $this->addSql('ALTER TABLE receipt ADD borrowing_request_id INT NOT NULL, ADD code VARCHAR(255) NOT NULL');
        $this->addSql('ALTER TABLE receipt ADD CONSTRAINT FK_5399B645542855AB FOREIGN KEY (borrowing_request_id) REFERENCES borrowing_request (id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_5399B645542855AB ON receipt (borrowing_request_id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE borrowing_request_book DROP FOREIGN KEY FK_F47A21D6542855AB');
        $this->addSql('ALTER TABLE borrowing_request_book DROP FOREIGN KEY FK_F47A21D616A2B381');
        $this->addSql('ALTER TABLE cart_book DROP FOREIGN KEY FK_2400A3081AD5CDBF');
        $this->addSql('ALTER TABLE cart_book DROP FOREIGN KEY FK_2400A30816A2B381');
        $this->addSql('DROP TABLE borrowing_request_book');
        $this->addSql('DROP TABLE cart_book');
        $this->addSql('ALTER TABLE borrowing_request DROP FOREIGN KEY FK_F35F6694CB944F1A');
        $this->addSql('DROP INDEX IDX_F35F6694CB944F1A ON borrowing_request');
        $this->addSql('ALTER TABLE borrowing_request DROP student_id, DROP status');
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY FK_BA388B7CB944F1A');
        $this->addSql('DROP INDEX UNIQ_BA388B7CB944F1A ON cart');
        $this->addSql('ALTER TABLE cart DROP student_id');
        $this->addSql('ALTER TABLE receipt DROP FOREIGN KEY FK_5399B645542855AB');
        $this->addSql('DROP INDEX UNIQ_5399B645542855AB ON receipt');
        $this->addSql('ALTER TABLE receipt DROP borrowing_request_id, DROP code');
    }
}
