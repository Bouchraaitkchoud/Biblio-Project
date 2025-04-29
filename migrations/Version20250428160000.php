<?php

declare(strict_types=1);

namespace DoctrineMigrations;

use Doctrine\DBAL\Schema\Schema;
use Doctrine\Migrations\AbstractMigration;

final class Version20250428160000 extends AbstractMigration
{
    public function getDescription(): string
    {
        return 'Create cart_item table';
    }

    public function up(Schema $schema): void
    {
        $this->addSql('CREATE TABLE cart_item (
            id INT AUTO_INCREMENT NOT NULL,
            cart_id INT NOT NULL,
            exemplaire_id INT NOT NULL,
            added_at DATETIME NOT NULL,
            PRIMARY KEY(id),
            INDEX IDX_F0FE25271AD5CDBF (cart_id),
            INDEX IDX_F0FE2527C5B75B3E (exemplaire_id),
            CONSTRAINT FK_F0FE25271AD5CDBF FOREIGN KEY (cart_id) REFERENCES cart (id) ON DELETE CASCADE,
            CONSTRAINT FK_F0FE2527C5B75B3E FOREIGN KEY (exemplaire_id) REFERENCES exemplaire (id)
        ) DEFAULT CHARACTER SET utf8mb4 COLLATE `utf8mb4_unicode_ci` ENGINE = InnoDB');
    }

    public function down(Schema $schema): void
    {
        $this->addSql('DROP TABLE cart_item');
    }
} 