<?php

namespace App\Repository;

use App\Data\SearchData;
use App\Entity\Produit;
use Doctrine\Bundle\DoctrineBundle\Repository\ServiceEntityRepository;
use Knp\Component\Pager\PaginatorInterface;
use Doctrine\Persistence\ManagerRegistry;

/**
 * @method Produit|null find($id, $lockMode = null, $lockVersion = null)
 * @method Produit|null findOneBy(array $criteria, array $orderBy = null)
 * @method Produit[]    findAll()
 * @method Produit[]    findBy(array $criteria, array $orderBy = null, $limit = null, $offset = null)
 */
class ProduitRepository extends ServiceEntityRepository
{
    public function __construct(ManagerRegistry $registry, PaginatorInterface $paginator)
    {
        parent::__construct($registry, Produit::class);
        $this->paginator = $paginator;
    }

    // /**
    //  * @return Produit[] Returns an array of Produit objects
    //  */
    /*
    public function findByExampleField($value)
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->orderBy('p.id', 'ASC')
            ->setMaxResults(10)
            ->getQuery()
            ->getResult()
        ;
    }
    */

    public function findByCategorie($categories){
        $query = $this->createQueryBuilder('produit')
                      ->select('produit')
                      ->leftJoin('produit.categorie', 'categorie')
                      ->addSelect('categorie')
                      ->setMaxResults(10);
 
        $query = $query->add('where', $query->expr()->in('categorie', ':categorie'))
                      ->setParameter('categorie', $categories);

        return $query->getQuery()->getResult();
    }

    public function findSearch(SearchData $search)
    {
        $query = $this
            ->createQueryBuilder('produit')
            ->select('produit', 'categorie', 'format')
            ->leftJoin('produit.categorie', 'categorie')
            ->leftJoin('produit.format', 'format');
        if(!empty($search->q))
        {
            $query = $query
                    ->andWhere('produit.titre LIKE :q')
                    ->setParameter('q', "%{$search->q}%");
        }

        if(!empty($search->categories))
        {
            $query = $query
                    ->andWhere('categorie.id IN (:categories)')
                    ->setParameter('categories', $search->categories);
        }

        if(!empty($search->formats))
        {
            $query = $query
                    ->andWhere('format.id IN (:formats)')
                    ->setParameter('formats', $search->formats);
        }

        $query = $query->getQuery();
        return $this->paginator->paginate(
            $query,
            $search->page,
            24
        );
    }

    /*
    public function findOneBySomeField($value): ?Produit
    {
        return $this->createQueryBuilder('p')
            ->andWhere('p.exampleField = :val')
            ->setParameter('val', $value)
            ->getQuery()
            ->getOneOrNullResult()
        ;
    }
    */
}
