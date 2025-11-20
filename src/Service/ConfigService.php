<?php
// filepath: c:\Users\Hp\Biblio-Project\biblio-project-backend\src\Service\ConfigService.php

namespace App\Service;

use App\Entity\SystemConfig;
use Doctrine\ORM\EntityManagerInterface;

class ConfigService
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {}

    public function getMaxBooksPerOrder(): int
    {
        $config = $this->entityManager->getRepository(SystemConfig::class)
            ->findOneBy(['key' => 'max_books_per_order']);

        if (!$config) {
            return 5; // Default value
        }

        return (int)$config->getValue();
    }

    public function setMaxBooksPerOrder(int $maxBooks): void
    {
        $config = $this->entityManager->getRepository(SystemConfig::class)
            ->findOneBy(['key' => 'max_books_per_order']);

        if (!$config) {
            $config = new SystemConfig();
            $config->setKey('max_books_per_order');
            $config->setDescription('Maximum number of books a lecteur can borrow per order');
            $this->entityManager->persist($config);
        }

        $config->setValue((string)$maxBooks);
        $this->entityManager->flush();
    }
}