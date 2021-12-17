<?php

namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

class DisController extends AbstractController
{
    #[Route('/dis', name: 'dis')]
    public function index(): Response
    {
        return $this->render('base.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }


    #[Route('/home', name: 'home')]
    public function home(): Response
    {
        return $this->render('home.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }


    #[Route('/artiste', name: 'artiste')]
    public function article(): Response
    {
        return $this->render('artiste.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }


    #[Route('/fiche_produit', name: 'fiche_produit')]
    public function ficheProduit(): Response
    {
        return $this->render('fiche_produit.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }


    #[Route('/profil', name: 'profil')]
    public function pageProfil(): Response
    {
        return $this->render('profil.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }
    
}
