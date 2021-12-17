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

    #[Route('/nos_artistes', name: 'nos_artistes')]
    public function article(): Response
    {
        return $this->render('nos_artistes.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }

    #[Route('/artiste', name: 'artiste')]
    public function artiste(): Response
    {
        return $this->render('artiste.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }

    #[Route('/tous_nos_produits', name: 'tous_nos_produits')]
    public function produits(): Response
    {
        return $this->render('tous_nos_produits.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }

    #[Route('/à_propos', name: 'à_propos')]
    public function about(): Response
    {
        return $this->render('à_propos.html.twig', [
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
}
