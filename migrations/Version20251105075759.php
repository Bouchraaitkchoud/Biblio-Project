<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251105075759 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE messenger_messages (id BIGINT AUTO_INCREMENT NOT NULL, body LONGTEXT NOT NULL, headers LONGTEXT NOT NULL, queue_name VARCHAR(190) NOT NULL, created_at DATETIME NOT NULL COMMENT \'(DC2Type:datetime_immutable)\', available_at DATETIME NOT NULL COMMENT \'(DC2Type:datetime_immutable)\', delivered_at DATETIME DEFAULT NULL COMMENT \'(DC2Type:datetime_immutable)\', INDEX IDX_75EA56E0FB7336F0 (queue_name), INDEX IDX_75EA56E0E3BD61CE (available_at), INDEX IDX_75EA56E016BA31DB (delivered_at), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE book CHANGE isbn isbn VARCHAR(50) DEFAULT NULL, CHANGE description description LONGTEXT DEFAULT NULL, CHANGE document_type document_type VARCHAR(50) DEFAULT NULL');
        $this->addSql('ALTER TABLE book_author ADD CONSTRAINT FK_9478D34516A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE book_author ADD CONSTRAINT FK_9478D345F675F31B FOREIGN KEY (author_id) REFERENCES author (id) ON DELETE CASCADE');
        $this->addSql('CREATE INDEX IDX_9478D34516A2B381 ON book_author (book_id)');
        $this->addSql('CREATE INDEX IDX_9478D345F675F31B ON book_author (author_id)');
        $this->addSql('ALTER TABLE book_discipline ADD CONSTRAINT FK_EA13A48C16A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE book_discipline ADD CONSTRAINT FK_EA13A48CA5522701 FOREIGN KEY (discipline_id) REFERENCES discipline (id) ON DELETE CASCADE');
        $this->addSql('CREATE INDEX IDX_EA13A48C16A2B381 ON book_discipline (book_id)');
        $this->addSql('CREATE INDEX IDX_EA13A48CA5522701 ON book_discipline (discipline_id)');
        $this->addSql('ALTER TABLE book_publisher ADD CONSTRAINT FK_8E46C30016A2B381 FOREIGN KEY (book_id) REFERENCES book (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE book_publisher ADD CONSTRAINT FK_8E46C30040C86FCE FOREIGN KEY (publisher_id) REFERENCES publisher (id) ON DELETE CASCADE');
        $this->addSql('CREATE INDEX IDX_8E46C30016A2B381 ON book_publisher (book_id)');
        $this->addSql('CREATE INDEX IDX_8E46C30040C86FCE ON book_publisher (publisher_id)');
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY fk_cart_processed_by');
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY fk_cart_user');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT FK_BA388B7A76ED395 FOREIGN KEY (user_id) REFERENCES `user` (id)');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT FK_BA388B72FFD4FD3 FOREIGN KEY (processed_by_id) REFERENCES `user` (id)');
        $this->addSql('ALTER TABLE cart RENAME INDEX fk_cart_user TO IDX_BA388B7A76ED395');
        $this->addSql('ALTER TABLE cart RENAME INDEX fk_cart_processed_by TO IDX_BA388B72FFD4FD3');
        $this->addSql('ALTER TABLE cart_item RENAME INDEX fk2_idx TO IDX_F0FE25271AD5CDBF');
        $this->addSql('ALTER TABLE cart_item RENAME INDEX fk1_idx TO IDX_F0FE25275843AA21');
        $this->addSql('ALTER TABLE exemplaire CHANGE book_id book_id INT NOT NULL, CHANGE barcode barcode VARCHAR(50) NOT NULL, CHANGE acquisition_mode acquisition_mode VARCHAR(50) DEFAULT NULL, CHANGE status status VARCHAR(20) DEFAULT NULL');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_5EF83C9297AE0266 ON exemplaire (barcode)');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX fk1_idx TO IDX_5EF83C9216A2B381');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX fk2_idx TO IDX_5EF83C9264D218E');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_11D3C93858FE7A72 ON lecteur (code_admission)');
        $this->addSql('ALTER TABLE orders DROP FOREIGN KEY FK_orders_exemplaire');
        $this->addSql('ALTER TABLE orders DROP FOREIGN KEY FK_orders_user');
        $this->addSql('ALTER TABLE orders CHANGE exemplaire_id exemplaire_id INT NOT NULL');
        $this->addSql('ALTER TABLE orders ADD CONSTRAINT FK_E52FFDEEA76ED395 FOREIGN KEY (user_id) REFERENCES `user` (id)');
        $this->addSql('ALTER TABLE orders ADD CONSTRAINT FK_E52FFDEE5843AA21 FOREIGN KEY (exemplaire_id) REFERENCES exemplaire (id)');
        $this->addSql('ALTER TABLE orders RENAME INDEX fk_orders_user TO IDX_E52FFDEEA76ED395');
        $this->addSql('ALTER TABLE orders RENAME INDEX fk_orders_exemplaire TO IDX_E52FFDEE5843AA21');
        $this->addSql('ALTER TABLE receipt CHANGE code code VARCHAR(50) NOT NULL, CHANGE generated_at generated_at DATETIME NOT NULL');
        $this->addSql('ALTER TABLE receipt RENAME INDEX cart_id_unique TO UNIQ_5399B6451AD5CDBF');
        $this->addSql('ALTER TABLE user DROP is_verified, DROP privileges');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D649AA08CB10 ON user (login)');
        $this->addSql('ALTER TABLE user RENAME INDEX email_unique TO UNIQ_IDENTIFIER_EMAIL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('DROP TABLE messenger_messages');
        $this->addSql('DROP INDEX UNIQ_11D3C93858FE7A72 ON lecteur');
        $this->addSql('DROP INDEX UNIQ_8D93D649AA08CB10 ON `user`');
        $this->addSql('ALTER TABLE `user` ADD is_verified TINYINT(1) NOT NULL, ADD privileges JSON NOT NULL');
        $this->addSql('ALTER TABLE `user` RENAME INDEX uniq_identifier_email TO email_UNIQUE');
        $this->addSql('ALTER TABLE book CHANGE description description VARCHAR(255) DEFAULT NULL, CHANGE isbn isbn VARCHAR(255) DEFAULT NULL, CHANGE document_type document_type VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE book_author DROP FOREIGN KEY FK_9478D34516A2B381');
        $this->addSql('ALTER TABLE book_author DROP FOREIGN KEY FK_9478D345F675F31B');
        $this->addSql('DROP INDEX IDX_9478D34516A2B381 ON book_author');
        $this->addSql('DROP INDEX IDX_9478D345F675F31B ON book_author');
        $this->addSql('ALTER TABLE book_discipline DROP FOREIGN KEY FK_EA13A48C16A2B381');
        $this->addSql('ALTER TABLE book_discipline DROP FOREIGN KEY FK_EA13A48CA5522701');
        $this->addSql('DROP INDEX IDX_EA13A48C16A2B381 ON book_discipline');
        $this->addSql('DROP INDEX IDX_EA13A48CA5522701 ON book_discipline');
        $this->addSql('ALTER TABLE book_publisher DROP FOREIGN KEY FK_8E46C30016A2B381');
        $this->addSql('ALTER TABLE book_publisher DROP FOREIGN KEY FK_8E46C30040C86FCE');
        $this->addSql('DROP INDEX IDX_8E46C30016A2B381 ON book_publisher');
        $this->addSql('DROP INDEX IDX_8E46C30040C86FCE ON book_publisher');
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY FK_BA388B7A76ED395');
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY FK_BA388B72FFD4FD3');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT fk_cart_processed_by FOREIGN KEY (processed_by_id) REFERENCES user (id) ON UPDATE CASCADE ON DELETE SET NULL');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT fk_cart_user FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE CASCADE ON DELETE CASCADE');
        $this->addSql('ALTER TABLE cart RENAME INDEX idx_ba388b7a76ed395 TO fk_cart_user');
        $this->addSql('ALTER TABLE cart RENAME INDEX idx_ba388b72ffd4fd3 TO fk_cart_processed_by');
        $this->addSql('ALTER TABLE receipt CHANGE code code TEXT NOT NULL, CHANGE generated_at generated_at TEXT NOT NULL');
        $this->addSql('ALTER TABLE receipt RENAME INDEX uniq_5399b6451ad5cdbf TO cart_id_UNIQUE');
        $this->addSql('DROP INDEX UNIQ_5EF83C9297AE0266 ON exemplaire');
        $this->addSql('ALTER TABLE exemplaire CHANGE book_id book_id INT DEFAULT NULL, CHANGE barcode barcode VARCHAR(255) DEFAULT NULL, CHANGE acquisition_mode acquisition_mode VARCHAR(255) DEFAULT NULL, CHANGE status status VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX idx_5ef83c9216a2b381 TO FK1_idx');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX idx_5ef83c9264d218e TO FK2_idx');
        $this->addSql('ALTER TABLE cart_item RENAME INDEX idx_f0fe25275843aa21 TO FK1_idx');
        $this->addSql('ALTER TABLE cart_item RENAME INDEX idx_f0fe25271ad5cdbf TO FK2_idx');
        $this->addSql('ALTER TABLE orders DROP FOREIGN KEY FK_E52FFDEEA76ED395');
        $this->addSql('ALTER TABLE orders DROP FOREIGN KEY FK_E52FFDEE5843AA21');
        $this->addSql('ALTER TABLE orders CHANGE exemplaire_id exemplaire_id INT DEFAULT NULL');
        $this->addSql('ALTER TABLE orders ADD CONSTRAINT FK_orders_exemplaire FOREIGN KEY (exemplaire_id) REFERENCES exemplaire (id) ON UPDATE CASCADE ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE orders ADD CONSTRAINT FK_orders_user FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE CASCADE ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE orders RENAME INDEX idx_e52ffdeea76ed395 TO FK_orders_user');
        $this->addSql('ALTER TABLE orders RENAME INDEX idx_e52ffdee5843aa21 TO FK_orders_exemplaire');
    }
}
