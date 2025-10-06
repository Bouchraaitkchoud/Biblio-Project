<?php

namespace App\Repository;

use App\Entity\Publisher;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Tools\Pagination\Paginator;

/**
 * @extends ServiceEntityRepository<Publisher>
 */
class PublisherRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Publisher::class);
    }

    public function save(Publisher $entity, bool $flush = false): void
    {
        $this->getEntityManager()->persist($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }

    public function remove(Publisher $entity, bool $flush = false): void
    {
        $this->getEntityManager()->remove($entity);

        if ($flush) {
            $this->getEntityManager()->flush();
        }
    }
    
    public function findByName($searchTerm): array
    {
        return $this->createQueryBuilder('p')
            ->where('LOWER(p.name) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->orderBy('p.name', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult();
    }
    
    public function searchByName(string $searchTerm): array
    {
        return $this->createQueryBuilder('p')
            ->where('LOWER(p.name) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->orderBy('p.name', 'ASC')
            ->setMaxResults(20)
            ->getQuery()
            ->getResult();
    }
    
    /**
     * Get paginated list of publishers with optional search filter
     */
    public function getPaginatedPublishers(int $page = 1, int $limit = 20, ?string $searchTerm = null): array
    {
        $qb = $this->createQueryBuilder('p')
            ->orderBy('p.name', 'ASC');
            
        if ($searchTerm) {
            $qb->where('LOWER(p.name) LIKE LOWER(:searchTerm)')
               ->setParameter('searchTerm', '%' . $searchTerm . '%');
        }
        
        $qb->setFirstResult(($page - 1) * $limit)
           ->setMaxResults($limit);
        
        $paginator = new Paginator($qb);
        $totalItems = count($paginator);
        $totalPages = ceil($totalItems / $limit);
        
        return [
            'publishers' => $paginator,
            'totalItems' => $totalItems,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'limit' => $limit
        ];
    }
}