<?php

namespace App\Controller;

use App\Entity\Produit;
use App\Entity\User;
use App\Form\RegistrationFormType;
use App\Repository\UserRepository;
use App\Repository\ProduitRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;

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


    #[Route('/produits', name: 'produits')]
    public function produits(ProduitRepository $repoProduct): Response
    {

        $produit = $repoProduct->findAll();

        

        return $this->render('base/tous_nos_produits.html.twig', [
            'controller_name' => 'DisController',
            'produit' => $produit
        ]);
    }

    

    #[Route('/a_propos', name: 'a_propos')]
    public function about(): Response
    {
        return $this->render('base/a_propos.html.twig', [
            'controller_name' => 'DisController',
        ]);
    }


    #[Route('/', name: 'home')]
    public function home(ProduitRepository $repoProduct): Response
    {
        $produit = $repoProduct->findAll();

        $derniers_produit = $repoProduct->findBy([], ['id' => 'DESC'], 9, null);

        return $this->render('base/home.html.twig', [
            'controller_name' => 'DisController',
            'produit' => $produit,
            'derniers_produit' => $derniers_produit
        ]);
    }

    #[Route('/fiche_produit/{id}', name: 'fiche_produit')]
    public function ficheProduit(Produit $produit, ProduitRepository $repoProduct): Response
    {
        $categories = array();
        foreach($produit->getCategorie() as $category)
        {
            array_push($categories, $category);
        }
        
        $sameCategorie = $repoProduct->findByCategorie($categories);

        return $this->render('base/fiche_produit.html.twig', [
            'produit' => $produit,
            'sameCategorie' => $sameCategorie
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

    #[Route('/profil/{id}/edit', name: 'edit_profil_user')]
    public function editProfilUser(User $user, Request $request, EntityManagerInterface $manager, SluggerInterface $slugger): Response
    {

        $userForm = $this->createForm(RegistrationFormType::class, $user, [
            'userUpdate' => true 
        ]);
        $ProfilBdd = $user->getImageProfil();

        $userForm->handleRequest($request);

        if ($userForm->isSubmitted() && $userForm->isValid()) {
            // encode the plain password

            $profilphoto = $userForm->get('imageProfil')->getData();
            if($profilphoto)
            {
                $nomOriginePhoto = pathinfo($profilphoto->getClientOriginalName(), PATHINFO_FILENAME);
                //dd($nomOriginePhoto);

                // cela est necessaire pour inclure en toute sécurité le nom du fichier dans l'URL
                $secureNomPhoto = $slugger->slug($nomOriginePhoto);

                $nouveauNomFichier = $secureNomPhoto.' - '.uniqid().'.'.$profilphoto->guessExtension();
                // dd($nouveauNomFichier);
                try
                {
                    $profilphoto->move(
                        $this->getParameter('photo_directory'),
                        $nouveauNomFichier
                    );
                }
                catch(FileException $e)
                {

                }

                $user->setImageProfil($nouveauNomFichier);

            }
            else
            {
                $user->setImageProfil($ProfilBdd);                    
            }


            $manager->persist($user);
            $manager->flush();

            return $this->redirectToRoute('app_logout');
        }

        return $this->render('base/user_edit.html.twig', [
            'userForm' => $userForm->createView(),
            'photoBdd' => $ProfilBdd,
        ]);
    }
    
    #[Route('/panier', name: 'panier')]
    public function panier(Session $session): Response
    {
        $panier = $session->get("panier");

        // features :
        // Ajout frai de livraison si panier moins de 50€

        return $this->render('base/panier.html.twig', [
            'panier' => $panier
        ]);
    }

    #[Route('artiste/{id}', name: 'profil_vendeur')]
    public function mon_profil(User $user): Response 
    {


        return $this->render('base/profil_vendeur.html.twig', [
            'vendeur' => $user
        ]);
    }

    
}
