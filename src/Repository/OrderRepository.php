<?php

namespace App\Repository;

use App\Entity\Order;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Doctrine\Persistence\ManagerRegistry;

class OrderRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry)
    {
        parent::__construct($registry, Order::class);
    }

    public function countActiveBooksForLecteur($lecteur): int
    {
        return $this->createQueryBuilder('o')
            ->select('count(oi.id)')
            ->join('o.items', 'oi')
            ->where('o.lecteur = :lecteur')
            ->andWhere('o.status = :pending OR (o.status = :approved AND o.returnedAt IS NULL)')
            ->setParameter('lecteur', $lecteur)
            ->setParameter('pending', 'pending')
            ->setParameter('approved', 'approved')
            ->getQuery()
            ->getSingleScalarResult();
    }
}
