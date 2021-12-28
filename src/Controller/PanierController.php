<?php

namespace App\Controller;

use App\Entity\Commande;
use App\Entity\DetailsCommande;
use App\Entity\Produit;
use App\Repository\FormatRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\ProduitRepository;
use Doctrine\ORM\EntityManagerInterface;
use PHPUnit\TextUI\Command;
use Symfony\Component\HttpFoundation\Request;

class PanierController extends AbstractController
{
    /**
    * @Route("/add/panier", name="ajout_panier")
    */
    public function index(SessionInterface $session, Request $request, ProduitRepository $produitRepository, FormatRepository $formatRepository)
    {
        $panier = $session->get("panier", []);

        $id_produit = intval($request->query->get('id_produit'));
        $format = intval($request->query->get('format'));
        $quantite = intval($request->query->get('quantity'));

        $produit = $produitRepository->find($id_produit);
        $format_obj = $formatRepository->find($format);

        $all_ready_have = false;
        foreach($panier as $key => $id)
        {
            if($id['produit']->getId() == $id_produit)
            {
                if($id['format']->getId() == $format)
                {
                    $all_ready_have = true;
                    $emplacement = $key;
                }
            }
        }

        if($all_ready_have)
        { 
            $panier[$emplacement]['quantite'] += $quantite;
        }
        else // Sinon, l'id_article n'exsite pas dans la session $_SESSION['panier']['id_article'], on ajoute l'article normalement dans le panier
        {
            $newValues = [];
            $newValues['produit'] = $produit;
            $newValues['quantite'] = $quantite;
            $newValues['format'] = $format_obj;
            array_push($panier, $newValues);
        }
        $session->set('panier', $panier);
        //$session->remove('panier');
        // return $this->render('panier/index.html.twig', [
        //     'panier' => $panier
        // ]);
        return $this->redirectToRoute("panier");
    }

    /**
     * @Route("/remove/{id}", name="remove")
     */
    public function remove(SessionInterface $session, $id)
    {
        //On récupere le panier actuel
        $panier = $session->get("panier", []);

        if(!empty($panier[$id]))
        {
            unset($panier[$id]);
        }
        
        //On sauvegarde dans la session
        $session->set("panier", $panier);
        
        return $this->redirectToRoute("panier");
    }

    /**
     * @Route("/delete", name="delete_all")
     */
    public function deleteAll(SessionInterface $session)
    {
       //On récupere le panier actuel
        $session->set("panier", []);

        return $this->redirectToRoute("panier");
    }

    /**
     * @Route("/panier/achat", name="validatePanier")
     */
    public function validPanier(SessionInterface $session, EntityManagerInterface $manager) : Response
    {
        $panier = $session->get("panier", []);
        $commande = new Commande;
        $commande->setDateCommande(new \DateTime());
        $commande->setUser($this->getUser());
        $montant = 0;
        foreach($panier as $produitPanier)
        {
            $prix = $produitPanier['quantite'] * $produitPanier['format']->getPrix();
            $montant += $prix;
        }

        $commande->setMontant($montant);

        $manager->persist($commande);



        foreach($panier as $produitPanier)
        {
            $detailsCommande = new DetailsCommande;
            $detailsCommande->setProduitId($produitPanier['produit']->getId());
            $detailsCommande->setFormatId($produitPanier['format']->getId());
            $detailsCommande->setQuantite($produitPanier['quantite']);
            $prix = $produitPanier['quantite'] * $produitPanier['format']->getPrix();
            $detailsCommande->setPrix($prix);
            $detailsCommande->setCommande($commande);
            $manager->persist($detailsCommande);

        }
        $manager->flush();        

        $this->addFlash('success', "Félicitations ! Votre commande a été enregistré avec succès !");
        $session->remove('panier');

        return $this->redirectToRoute("profil");
    }

}
