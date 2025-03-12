<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250304151911 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE book (id INT AUTO_INCREMENT NOT NULL, section_id INT NOT NULL, title VARCHAR(255) NOT NULL, author VARCHAR(255) NOT NULL, INDEX IDX_CBE5A331D823E37A (section_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE borrowing_request (id INT AUTO_INCREMENT NOT NULL, student_id INT NOT NULL, status VARCHAR(255) NOT NULL, INDEX IDX_F35F6694CB944F1A (student_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE borrowing_request_book (borrowing_request_id INT NOT NULL, book_id INT NOT NULL, INDEX IDX_F47A21D6542855AB (borrowing_request_id), INDEX IDX_F47A21D616A2B381 (book_id), PRIMARY KEY(borrowing_request_id, book_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE cart (id INT AUTO_INCREMENT NOT NULL, student_id INT NOT NULL, UNIQUE INDEX UNIQ_BA388B7CB944F1A (student_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE cart_book (cart_id INT NOT NULL, book_id INT NOT NULL, INDEX IDX_2400A3081AD5CDBF (cart_id), INDEX IDX_2400A30816A2B381 (book_id), PRIMARY KEY(cart_id, book_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE domain (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE receipt (id INT AUTO_INCREMENT NOT NULL, borrowing_request_id INT NOT NULL, code VARCHAR(255) NOT NULL, UNIQUE INDEX UNIQ_5399B645542855AB (borrowing_request_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE section (id INT AUTO_INCREMENT NOT NULL, domain_id INT NOT NULL, name VARCHAR(255) NOT NULL, INDEX IDX_2D737AEF115F0EE5 (domain_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE `user` (id INT AUTO_INCREMENT NOT NULL, email VARCHAR(180) NOT NULL, roles JSON NOT NULL, password VARCHAR(255) NOT NULL, is_verified TINYINT(1) NOT NULL, UNIQUE INDEX UNIQ_IDENTIFIER_EMAIL (email), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE messenger_messages (id BIGINT AUTO_INCREMENT NOT NULL, body LONGTEXT NOT NULL, headers LONGTEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at DATETIME NOT NULL COMMENT \'(DC2Type:datetime_immutable)\', available_at DATETIME NOT NULL COMMENT \'(DC2Type:datetime_immutable)\', delivered_at DATETIME DEFAULT NULL COMMENT \'(DC2Type:datetime_immutable)\', INDEX IDX_75EA56E0FB7336F0 (queue_name), INDEX IDX_75EA56E0E3BD61CE (available_at), INDEX IDX_75EA56E016BA31DB (delivered_at), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE book ADD CONSTRAINT FK_CBE5A331D823E37A FOREIGN KEY (section_id) REFERENCES section (id)');
        $this->addSql('ALTER TABLE borrowing_request ADD CONSTRAINT FK_F35F6694CB944F1A FOREIGN KEY (student_id) REFERENCES `user` (id)');
        $this->addSql('ALTER TABLE borrowing_request_book ADD CONSTRAINT FK_F47A21D6542855AB FOREIGN KEY (borrowing_request_id) REFERENCES borrowing_request (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE borrowing_request_book ADD CONSTRAINT FK_F47A21D616A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT FK_BA388B7CB944F1A FOREIGN KEY (student_id) REFERENCES `user` (id)');
        $this->addSql('ALTER TABLE cart_book ADD CONSTRAINT FK_2400A3081AD5CDBF FOREIGN KEY (cart_id) REFERENCES cart (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE cart_book ADD CONSTRAINT FK_2400A30816A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE receipt ADD CONSTRAINT FK_5399B645542855AB FOREIGN KEY (borrowing_request_id) REFERENCES borrowing_request (id)');
        $this->addSql('ALTER TABLE section ADD CONSTRAINT FK_2D737AEF115F0EE5 FOREIGN KEY (domain_id) REFERENCES domain (id)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE book DROP FOREIGN KEY FK_CBE5A331D823E37A');
        $this->addSql('ALTER TABLE borrowing_request DROP FOREIGN KEY FK_F35F6694CB944F1A');
        $this->addSql('ALTER TABLE borrowing_request_book DROP FOREIGN KEY FK_F47A21D6542855AB');
        $this->addSql('ALTER TABLE borrowing_request_book DROP FOREIGN KEY FK_F47A21D616A2B381');
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY FK_BA388B7CB944F1A');
        $this->addSql('ALTER TABLE cart_book DROP FOREIGN KEY FK_2400A3081AD5CDBF');
        $this->addSql('ALTER TABLE cart_book DROP FOREIGN KEY FK_2400A30816A2B381');
        $this->addSql('ALTER TABLE receipt DROP FOREIGN KEY FK_5399B645542855AB');
        $this->addSql('ALTER TABLE section DROP FOREIGN KEY FK_2D737AEF115F0EE5');
        $this->addSql('DROP TABLE book');
        $this->addSql('DROP TABLE borrowing_request');
        $this->addSql('DROP TABLE borrowing_request_book');
        $this->addSql('DROP TABLE cart');
        $this->addSql('DROP TABLE cart_book');
        $this->addSql('DROP TABLE domain');
        $this->addSql('DROP TABLE receipt');
        $this->addSql('DROP TABLE section');
        $this->addSql('DROP TABLE `user`');
        $this->addSql('DROP TABLE messenger_messages');
    }
}
