<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251108184915 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE cart DROP FOREIGN KEY FK_BA388B72FFD4FD3');
        $this->addSql('DROP INDEX IDX_BA388B72FFD4FD3 ON cart');
        $this->addSql('ALTER TABLE cart DROP processed_by_id, DROP processed_at');
        $this->addSql('ALTER TABLE cart RENAME INDEX idx_ba388b7a76ed395 TO IDX_BA388B749DB9E60');
        $this->addSql('ALTER TABLE exemplaire CHANGE book_id book_id INT NOT NULL, CHANGE barcode barcode VARCHAR(50) NOT NULL, CHANGE acquisition_mode acquisition_mode VARCHAR(50) DEFAULT NULL, CHANGE status status VARCHAR(20) DEFAULT NULL');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_5EF83C9297AE0266 ON exemplaire (barcode)');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX fk1_idx TO IDX_5EF83C9216A2B381');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX fk2_idx TO IDX_5EF83C9264D218E');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_11D3C93858FE7A72 ON lecteur (code_admission)');
        $this->addSql('ALTER TABLE order_item DROP FOREIGN KEY order_item_ibfk_1');
        $this->addSql('ALTER TABLE order_item ADD CONSTRAINT FK_52EA1F098D9F6D38 FOREIGN KEY (order_id) REFERENCES orders (id)');
        $this->addSql('ALTER TABLE order_item RENAME INDEX order_id TO IDX_52EA1F098D9F6D38');
        $this->addSql('ALTER TABLE order_item RENAME INDEX exemplaire_id TO IDX_52EA1F095843AA21');
        $this->addSql('ALTER TABLE orders RENAME INDEX fk_orders_user TO IDX_E52FFDEE49DB9E60');
        $this->addSql('ALTER TABLE orders RENAME INDEX fk_orders_processed_by TO IDX_E52FFDEE2FFD4FD3');
        $this->addSql('ALTER TABLE receipt CHANGE code code VARCHAR(50) NOT NULL, CHANGE generated_at generated_at DATETIME NOT NULL');
        $this->addSql('ALTER TABLE receipt RENAME INDEX cart_id_unique TO UNIQ_5399B6451AD5CDBF');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D649AA08CB10 ON user (login)');
        $this->addSql('ALTER TABLE user RENAME INDEX email_unique TO UNIQ_IDENTIFIER_EMAIL');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE order_item DROP FOREIGN KEY FK_52EA1F098D9F6D38');
        $this->addSql('ALTER TABLE order_item ADD CONSTRAINT order_item_ibfk_1 FOREIGN KEY (order_id) REFERENCES orders (id) ON UPDATE NO ACTION ON DELETE CASCADE');
        $this->addSql('ALTER TABLE order_item RENAME INDEX idx_52ea1f098d9f6d38 TO order_id');
        $this->addSql('ALTER TABLE order_item RENAME INDEX idx_52ea1f095843aa21 TO exemplaire_id');
        $this->addSql('DROP INDEX UNIQ_8D93D649AA08CB10 ON `user`');
        $this->addSql('ALTER TABLE `user` RENAME INDEX uniq_identifier_email TO email_UNIQUE');
        $this->addSql('ALTER TABLE cart ADD processed_by_id INT DEFAULT NULL, ADD processed_at DATETIME DEFAULT NULL');
        $this->addSql('ALTER TABLE cart ADD CONSTRAINT FK_BA388B72FFD4FD3 FOREIGN KEY (processed_by_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('CREATE INDEX IDX_BA388B72FFD4FD3 ON cart (processed_by_id)');
        $this->addSql('ALTER TABLE cart RENAME INDEX idx_ba388b749db9e60 TO IDX_BA388B7A76ED395');
        $this->addSql('ALTER TABLE receipt CHANGE code code TEXT NOT NULL, CHANGE generated_at generated_at TEXT NOT NULL');
        $this->addSql('ALTER TABLE receipt RENAME INDEX uniq_5399b6451ad5cdbf TO cart_id_UNIQUE');
        $this->addSql('DROP INDEX UNIQ_11D3C93858FE7A72 ON lecteur');
        $this->addSql('DROP INDEX UNIQ_5EF83C9297AE0266 ON exemplaire');
        $this->addSql('ALTER TABLE exemplaire CHANGE book_id book_id INT DEFAULT NULL, CHANGE barcode barcode VARCHAR(255) DEFAULT NULL, CHANGE acquisition_mode acquisition_mode VARCHAR(255) DEFAULT NULL, CHANGE status status VARCHAR(255) DEFAULT NULL');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX idx_5ef83c9216a2b381 TO FK1_idx');
        $this->addSql('ALTER TABLE exemplaire RENAME INDEX idx_5ef83c9264d218e TO FK2_idx');
        $this->addSql('ALTER TABLE orders RENAME INDEX idx_e52ffdee49db9e60 TO FK_orders_user');
        $this->addSql('ALTER TABLE orders RENAME INDEX idx_e52ffdee2ffd4fd3 TO FK_orders_processed_by');
    }
}
