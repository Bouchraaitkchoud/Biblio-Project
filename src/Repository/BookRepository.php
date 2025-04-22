<?php

// src/Repository/BookRepository.php
namespace App\Repository;

use App\Entity\Book;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Tools\Pagination\Paginator;

/**
 * @extends ServiceEntityRepository<Book>
 */
class BookRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Book::class);
    }

    public function findByTitleOrAuthor($searchTerm): array
    {
        $qb = $this->createQueryBuilder('b')
            ->leftJoin('b.authors', 'a')
            ->where('LOWER(b.title) LIKE LOWER(:searchTerm)')
            ->orWhere('LOWER(a.name) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->orderBy('b.title', 'ASC')
            ->setMaxResults(20);
            
        return $qb->getQuery()->getResult();
    }
    
    /**
     * Get paginated list of books with optional search filter
     */
    public function getPaginatedBooks(int $page = 1, int $limit = 20, ?string $searchTerm = null): array
    {
        $qb = $this->createQueryBuilder('b')
            ->leftJoin('b.authors', 'a')
            ->leftJoin('b.section', 's')
            ->orderBy('b.title', 'ASC');
            
        if ($searchTerm) {
            $qb->where('LOWER(b.title) LIKE LOWER(:searchTerm)')
               ->orWhere('LOWER(a.name) LIKE LOWER(:searchTerm)')
               ->orWhere('LOWER(b.isbn) LIKE LOWER(:searchTerm)')
               ->setParameter('searchTerm', '%' . $searchTerm . '%');
        }
        
        $qb->setFirstResult(($page - 1) * $limit)
           ->setMaxResults($limit);
        
        $paginator = new Paginator($qb);
        $totalItems = count($paginator);
        $totalPages = ceil($totalItems / $limit);
        
        return [
            'books' => $paginator,
            'totalItems' => $totalItems,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'limit' => $limit
        ];
    }
}
