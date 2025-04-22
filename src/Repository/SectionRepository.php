<?php
// src/Repository/SectionRepository.php
namespace App\Repository;

use App\Entity\Section;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;
use Doctrine\ORM\Tools\Pagination\Paginator;

/**
 * @extends ServiceEntityRepository<Section>
 */
class SectionRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Section::class);
    }

    public function findByName($searchTerm): array
    {
        return $this->createQueryBuilder('s')
            ->where('LOWER(s.name) LIKE LOWER(:searchTerm)')
            ->setParameter('searchTerm', '%' . $searchTerm . '%')
            ->getQuery()
            ->getResult();
    }
    
    /**
     * Get paginated list of sections with optional search filter
     */
    public function getPaginatedSections(int $page = 1, int $limit = 20, ?string $searchTerm = null): array
    {
        $qb = $this->createQueryBuilder('s')
            ->leftJoin('s.domain', 'd')
            ->addSelect('d')
            ->orderBy('s.name', 'ASC');
            
        if ($searchTerm) {
            $qb->where('LOWER(s.name) LIKE LOWER(:searchTerm)')
               ->orWhere('LOWER(d.name) LIKE LOWER(:searchTerm)')
               ->setParameter('searchTerm', '%' . $searchTerm . '%');
        }
        
        $qb->setFirstResult(($page - 1) * $limit)
           ->setMaxResults($limit);
        
        $paginator = new Paginator($qb);
        $totalItems = count($paginator);
        $totalPages = ceil($totalItems / $limit);
        
        return [
            'sections' => $paginator,
            'totalItems' => $totalItems,
            'totalPages' => $totalPages,
            'currentPage' => $page,
            'limit' => $limit
        ];
    }
}
