<?php

namespace App\Controller;

use App\Entity\Produit;
use App\Repository\FormatRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\SessionInterface;
use Symfony\Component\Routing\Annotation\Route;
use App\Repository\ProduitRepository;
use Symfony\Component\HttpFoundation\Request;

class PanierController extends AbstractController
{
    /**
    * @Route("/add/panier", name="ajout_panier")
    */
    public function index(SessionInterface $session, Request $request, ProduitRepository $produitRepository, FormatRepository $formatRepository)
    {
        $panier = $session->get("panier", []);
        if(empty($panier))
        {
            $panier[] = [];
        }

        $id_produit = intval($request->query->get('id_produit'));
        $format = intval($request->query->get('format'));
        $quantite = intval($request->query->get('quantity'));

        $produit = $produitRepository->find($id_produit);
        $format_obj = $formatRepository->find($format);

        $all_ready_have = false;
        foreach($panier as $key => $id)
        {
            if($id == $id_produit)
            {
                if($panier['format'][$key] == $format)
                {
                    $all_ready_have = true;
                    $emplacement = $key;
                }
            }
        }

        if($all_ready_have)
        { 
            $panier['quantite'][$emplacement] += $quantite;
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
        $session->remove('panier');
        return $this->render('panier/index.html.twig', [
            'panier' => $panier
        ]);
    }

    /**
     * @Route("/add/{id}", name="add")
     */
    public function add(Produit $product, SessionInterface $session)
    {
       //On récupere le panier actuel
       $panier = $session->get("panier", []);
        $id= $product->getId();

        if(!empty($panier[$id])){
            $panier[$id]++;
        }
        else {
            $panier[$id] = 1;
        }
        //On sauvegarde dans la session
        $session->set("panier", $panier);
        
        return $this->redirectToRoute("cart_index");
    }

    /**
     * @Route("/remove/{id}", name="remove")
     */
    public function remove(Produit $product, SessionInterface $session)
    {
       //On récupere le panier actuel
       $panier = $session->get("panier", []);
        $id= $product->getId();

        if(!empty($panier[$id]))
        {
            if($panier[$id] > 1)
            {
                $panier[$id]--;
            }
            else
            {
                unset($panier[$id]);
            }
        
        }
        
        //On sauvegarde dans la session
        $session->set("panier", $panier);
        
        return $this->redirectToRoute("cart_index");
    }

     /**
     * @Route("/delete/{id}", name="delete")
     */
    public function delete(Produit $product, SessionInterface $session)
    {
       //On récupere le panier actuel
       $panier = $session->get("panier", []);
        $id= $product->getId();

        if(!empty($panier[$id]))
        {
            unset($panier[$id]);
        }
        
        //On sauvegarde dans la session
        $session->set("panier", $panier);
        
        return $this->redirectToRoute("cart_index");
    }

    /**
     * @Route("/delete", name="delete_all")
     */
    public function deleteAll(SessionInterface $session)
    {
       //On récupere le panier actuel
        $session->set("panier", []);

        return $this->redirectToRoute("cart_index");
    }

}
