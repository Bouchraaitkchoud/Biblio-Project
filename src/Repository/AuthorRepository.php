<?php

namespace App\Repository;

use App\Entity\Author;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Tools\Pagination\Paginator;

/**
 * @extends ServiceEntityRepository<Author>
 */
class AuthorRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Author::class);
    }
    
    public function findByName($searchTerm): array
    {
        return $this->createQueryBuilder('a')
            ->where('LOWER(a.name) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->orderBy('a.name', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult();
    }
    
    public function searchByName(string $searchTerm): array
    {
        return $this->createQueryBuilder('a')
            ->where('LOWER(a.name) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->orderBy('a.name', 'ASC')
            ->setMaxResults(20)
            ->getQuery()
            ->getResult();
    }
    
    /**
     * Get paginated list of authors with optional search filter
     */
    public function getPaginatedAuthors(int $page = 1, int $limit = 20, ?string $searchTerm = null): array
    {
        $qb = $this->createQueryBuilder('a')
            ->orderBy('a.name', 'ASC');
            
        if ($searchTerm) {
            $qb->where('LOWER(a.name) LIKE LOWER(:searchTerm)')
               ->setParameter('searchTerm', '%' . $searchTerm . '%');
        }
        
        $qb->setFirstResult(($page - 1) * $limit)
           ->setMaxResults($limit);
        
        $paginator = new Paginator($qb);
        $totalItems = count($paginator);
        $totalPages = ceil($totalItems / $limit);
        
        return [
            'authors' => $paginator,
            'totalItems' => $totalItems,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'limit' => $limit
        ];
    }
} 