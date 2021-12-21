<?php

namespace App\Controller;

use App\Entity\User;
use App\Repository\UserRepository;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DisController extends AbstractController
{

    #[Route('/artistes', name: 'nos_artistes')]
    public function artistes(UserRepository $repoUser): Response
    {

        $vendeurs = $repoUser->findAll();

        return $this->render('base/nos_artistes.html.twig', [
            'vendeurs' => $vendeurs
        ]);
    }

    #[Route('/artiste/{id}', name: 'artiste')]
    public function artiste(User $user): Response
    {
        

        return $this->render('base/artiste.html.twig', [
            'user' => $user,
        ]);
    }


    #[Route('/produits', name: 'tous_nos_produits')]
    public function produits(): Response
    {
        return $this->render('base/tous_nos_produits.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }

    #[Route('/a_propos', name: 'a_propos')]
    public function about(): Response
    {
        return $this->render('base/a_propos.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }


    #[Route('/home', name: 'home')]
    public function home(): Response
    {
        return $this->render('base/home.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }



    #[Route('/fiche_produit', name: 'fiche_produit')]
    public function ficheProduit(): Response
    {
        return $this->render('base/fiche_produit.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }

    #[Route('/contact', name: 'contact')]
    public function fichecontact(): Response
    {
        return $this->render('base/contact.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }

    #[Route('/faq', name: 'faq')]
    public function fichefaq(): Response
    {
        return $this->render('base/faq.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }


    #[Route('/profil', name: 'profil')]
    public function pageProfil(): Response
    {
        return $this->render('base/profil.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }

    #[Route('/legal_notice', name: 'legal_notice')]
    public function pageNotice(): Response
    {
        return $this->render('base/legal_notice.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }
    
    #[Route('/panier', name: 'panier')]
    public function panier(): Response
    {
        return $this->render('base/panier.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }
}
