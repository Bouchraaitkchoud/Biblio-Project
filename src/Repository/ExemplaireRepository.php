<?php

namespace App\Repository;

use App\Entity\Exemplaire;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Psr\Log\LoggerInterface;

/**
 * @extends ServiceEntityRepository<Exemplaire>
 */
class ExemplaireRepository extends ServiceEntityRepository
{
    private $logger;

    public function __construct(ManagerRegistry $registry, LoggerInterface $logger)
    {
        parent::__construct($registry, Exemplaire::class);
        $this->logger = $logger;
    }

    public function findOneByBarcode(string $barcode): ?Exemplaire
    {
        try {
            $this->logger->info('Searching for exemplaire by barcode', ['barcode' => $barcode]);

            $qb = $this->createQueryBuilder('e')
                ->select('e', 'b')  // Select exemplaire and book
                ->join('e.book', 'b')  // Join with book
                ->where('e.barcode = :barcode')
                ->setParameter('barcode', $barcode)
                ->setMaxResults(1);  // Ensure we only get one result

            $result = $qb->getQuery()->getOneOrNullResult();

            if (!$result) {
                $this->logger->info('No exemplaire found for barcode', ['barcode' => $barcode]);
            } else {
                $this->logger->info('Found exemplaire', [
                    'barcode' => $barcode,
                    'exemplaire_id' => $result->getId(),
                    'status' => $result->getStatus()
                ]);
            }

            return $result;
        } catch (\Exception $e) {
            $this->logger->error('Error finding exemplaire by barcode', [
                'barcode' => $barcode,
                'error' => $e->getMessage(),
                'trace' => $e->getTraceAsString()
            ]);
            
            throw $e;
        }
    }
} 