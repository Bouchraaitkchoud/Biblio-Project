<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

/**
 * Auto-generated Migration: Please modify to your needs!
 */
final class Version20251010093623 extends AbstractMigration
{
    public function getDescription(): string
    {
        return '';
    }

    public function up(Schema $schema): void
    {
        // this up() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE section (id INT AUTO_INCREMENT NOT NULL, name VARCHAR(255) NOT NULL, label VARCHAR(255) NOT NULL, UNIQUE INDEX UNIQ_2D737AEF5E237E06 (name), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('CREATE TABLE user_section (user_id INT NOT NULL, section_id INT NOT NULL, INDEX IDX_757E64E5A76ED395 (user_id), INDEX IDX_757E64E5D823E37A (section_id), PRIMARY KEY(user_id, section_id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
        $this->addSql('ALTER TABLE user_section ADD CONSTRAINT FK_757E64E5A76ED395 FOREIGN KEY (user_id) REFERENCES `user` (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE user_section ADD CONSTRAINT FK_757E64E5D823E37A FOREIGN KEY (section_id) REFERENCES section (id) ON DELETE CASCADE');
        $this->addSql('ALTER TABLE loan DROP FOREIGN KEY FK_C5D30D031AD5CDBF');
        $this->addSql('ALTER TABLE loan DROP FOREIGN KEY FK_C5D30D032FFD4FD3');
        $this->addSql('ALTER TABLE loan DROP FOREIGN KEY FK_C5D30D035843AA21');
        $this->addSql('ALTER TABLE loan DROP FOREIGN KEY FK_C5D30D03A76ED395');
        $this->addSql('DROP TABLE loan');
        $this->addSql('ALTER TABLE user ADD login VARCHAR(255) NOT NULL, ADD nom VARCHAR(255) NOT NULL, ADD prenom VARCHAR(255) NOT NULL');
        $this->addSql('CREATE UNIQUE INDEX UNIQ_8D93D649AA08CB10 ON user (login)');
    }

    public function down(Schema $schema): void
    {
        // this down() migration is auto-generated, please modify it to your needs
        $this->addSql('CREATE TABLE loan (id INT AUTO_INCREMENT NOT NULL, user_id INT NOT NULL, exemplaire_id INT NOT NULL, cart_id INT DEFAULT NULL, processed_by_id INT DEFAULT NULL, loan_date DATETIME NOT NULL, due_date DATETIME NOT NULL, return_date DATETIME DEFAULT NULL, status VARCHAR(20) CHARACTER SET utf8mb4 NOT NULL COLLATE `utf8mb4_unicode_ci`, loan_duration_days INT NOT NULL, return_condition VARCHAR(255) CHARACTER SET utf8mb4 DEFAULT NULL COLLATE `utf8mb4_unicode_ci`, notes LONGTEXT CHARACTER SET utf8mb4 DEFAULT NULL COLLATE `utf8mb4_unicode_ci`, INDEX IDX_C5D30D031AD5CDBF (cart_id), INDEX IDX_C5D30D032FFD4FD3 (processed_by_id), INDEX IDX_C5D30D035843AA21 (exemplaire_id), INDEX IDX_C5D30D03A76ED395 (user_id), PRIMARY KEY(id)) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB COMMENT = \'\' ');
        $this->addSql('ALTER TABLE loan ADD CONSTRAINT FK_C5D30D031AD5CDBF FOREIGN KEY (cart_id) REFERENCES cart (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE loan ADD CONSTRAINT FK_C5D30D032FFD4FD3 FOREIGN KEY (processed_by_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE loan ADD CONSTRAINT FK_C5D30D035843AA21 FOREIGN KEY (exemplaire_id) REFERENCES exemplaire (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE loan ADD CONSTRAINT FK_C5D30D03A76ED395 FOREIGN KEY (user_id) REFERENCES user (id) ON UPDATE NO ACTION ON DELETE NO ACTION');
        $this->addSql('ALTER TABLE user_section DROP FOREIGN KEY FK_757E64E5A76ED395');
        $this->addSql('ALTER TABLE user_section DROP FOREIGN KEY FK_757E64E5D823E37A');
        $this->addSql('DROP TABLE section');
        $this->addSql('DROP TABLE user_section');
        $this->addSql('DROP INDEX UNIQ_8D93D649AA08CB10 ON `user`');
        $this->addSql('ALTER TABLE `user` DROP login, DROP nom, DROP prenom');
    }
}
