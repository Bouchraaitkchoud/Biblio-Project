<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20250325140309 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY cart_ibfk_1');
        $this->addSql('DROP INDEX user_id ON cart');
        $this->addSql('ALTER TABLE cart DROP user_id, CHANGE status status VARCHAR(20) NOT NULL, CHANGE created_at created_at DATETIME NOT NULL');
        $this->addSql('ALTER TABLE cart_book RENAME INDEX book_id TO IDX_2400A30816A2B381');
        $this->addSql('ALTER TABLE receipt DROP INDEX cart_id, ADD UNIQUE INDEX UNIQ_5399B6451AD5CDBF (cart_id)');
        $this->addSql('ALTER TABLE receipt ADD generated_at DATETIME NOT NULL, CHANGE code code VARCHAR(50) NOT NULL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE cart ADD user_id INT NOT NULL, CHANGE status status VARCHAR(20) DEFAULT \'draft\' NOT NULL, CHANGE created_at created_at DATETIME DEFAULT CURRENT_TIMESTAMP');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT cart_ibfk_1 FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('CREATE INDEX user_id ON cart (user_id)');
        $this->addSql('ALTER TABLE cart_book RENAME INDEX idx_2400a30816a2b381 TO book_id');
        $this->addSql('ALTER TABLE receipt DROP INDEX UNIQ_5399B6451AD5CDBF, ADD INDEX cart_id (cart_id)');
        $this->addSql('ALTER TABLE receipt DROP generated_at, CHANGE code code VARCHAR(255) NOT NULL');
    }
}
