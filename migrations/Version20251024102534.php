<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251024102534 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('ALTER TABLE user_section DROP FOREIGN KEY FK_757E64E5A76ED395');
        $this->addSql('ALTER TABLE user_section DROP FOREIGN KEY FK_757E64E5D823E37A');
        $this->addSql('DROP TABLE section');
        $this->addSql('DROP TABLE user_section');
        $this->addSql('ALTER TABLE exemplaire ADD CONSTRAINT FK_5EF83C92A5522701 FOREIGN KEY (discipline_id) REFERENCES discipline (id)');
        $this->addSql('CREATE INDEX IDX_5EF83C92A5522701 ON exemplaire (discipline_id)');
        $this->addSql('ALTER TABLE orders ADD exemplaire_id INT NOT NULL, ADD returned_at DATETIME DEFAULT NULL');
        $this->addSql('ALTER TABLE orders ADD CONSTRAINT FK_E52FFDEE5843AA21 FOREIGN KEY (exemplaire_id) REFERENCES exemplaire (id)');
        $this->addSql('CREATE INDEX IDX_E52FFDEE5843AA21 ON orders (exemplaire_id)');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D649AA08CB10 ON user (login)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE section (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, label VARCHAR(255) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, UNIQUE INDEX UNIQ_2D737AEF5E237E06 (name), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('CREATE TABLE user_section (user_id INT NOT NULL, section_id INT NOT NULL, INDEX IDX_757E64E5D823E37A (section_id), INDEX IDX_757E64E5A76ED395 (user_id), PRIMARY KEY(user_id, section_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE user_section ADD CONSTRAINT FK_757E64E5A76ED395 FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE CASCADE');
        $this->addSql('ALTER TABLE user_section ADD CONSTRAINT FK_757E64E5D823E37A FOREIGN KEY (section_id) REFERENCES section (id) ON UPDATE NO ACTION ON DELETE CASCADE');
        $this->addSql('ALTER TABLE exemplaire DROP FOREIGN KEY FK_5EF83C92A5522701');
        $this->addSql('DROP INDEX IDX_5EF83C92A5522701 ON exemplaire');
        $this->addSql('ALTER TABLE orders DROP FOREIGN KEY FK_E52FFDEE5843AA21');
        $this->addSql('DROP INDEX IDX_E52FFDEE5843AA21 ON orders');
        $this->addSql('ALTER TABLE orders DROP exemplaire_id, DROP returned_at');
        $this->addSql('DROP INDEX UNIQ_8D93D649AA08CB10 ON `user`');
    }
}
