<?php

namespace App\Controller;

use App\Data\SearchData;
use App\Entity\Commande;
use App\Entity\Commentaire;
use App\Entity\Produit;
use App\Entity\User;
use App\Form\CommentaireTypeFormType;
use App\Form\RegistrationFormType;
use App\Form\SearchFormType;
use App\Repository\CategorieRepository;
use App\Repository\DetailsCommandeRepository;
use App\Repository\FormatRepository;
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
    #[Route('/produits/{categorie}', name: 'produits_par_cat')]
    public function produits(ProduitRepository $repoProduct, Request $request): Response
    {

        // $cat = '';
        // if($categorie == "nouveaute")
        // {
        //     $produit = $repoProduct->findBy([], ['id' => 'DESC'], null , null);
        //     $cat = $categorie;
        // }
        // elseif($categorie)
        // {
        //     $category = $repoCategory->findBy(['titre' => $categorie], [], null , null);
        //     $cat = $categorie;
        //     $produit = $repoProduct->findByCategorie($category);
        // }
        // else
        // {
        //     $data = new SearchData();
        //     $produit = $repoProduct->findSearch($data);     
        // }        
        $data = new SearchData();
        $data->page = $request->get('page', 1);
        $searchForm = $this->createForm(SearchFormType::class, $data);
        $searchForm->handleRequest($request);
        $produit = $repoProduct->findSearch($data);

        return $this->render('base/tous_nos_produits.html.twig', [
            'produit' => $produit,
            'searchForm' => $searchForm->createView()
        ]);
    }

    

    #[Route('/a_propos', name: 'a_propos')]
    public function about(): Response
    {
        return $this->render('base/a_propos.html.twig');
    }


    #[Route('/', name: 'home')]
    public function home(ProduitRepository $repoProduct, DetailsCommandeRepository $repoDetailsCommande): Response
    {

        $derniers_produit = $repoProduct->findBy([], ['id' => 'DESC'], 9, null);

        $random_produit = $repoProduct->findBy([], null, 9, rand(0, 5));

        $all_details = $repoDetailsCommande->findAll();

        $produit_best_sellers = [];

        foreach($all_details as $detail)
        {
            if(!empty($produit_best_sellers[$detail->getProduitId()]))
            {
                $produit_best_sellers[$detail->getProduitId()] += $detail->getQuantite();
            }
            else
            {
                $produit_best_sellers[$detail->getProduitId()] = $detail->getQuantite();
            }
        }

        arsort($produit_best_sellers, SORT_NUMERIC);

        $bestSellers = [];

        foreach($produit_best_sellers as $id => $quantite)
        {
            array_push($bestSellers, $repoProduct->find($id));
        }


        return $this->render('base/home.html.twig', [
            'derniers_produit' => $derniers_produit,
            'random_produit' => $random_produit,
            'best_sellers' => $bestSellers
        ]);
    }

    #[Route('/fiche_produit/{id}', name: 'fiche_produit')]
    public function ficheProduit(Produit $produit, ProduitRepository $repoProduct, EntityManagerInterface $manager, Request $request): Response
    {
        $categories = array();
        foreach($produit->getCategorie() as $category)
        {
            array_push($categories, $category);
        }
        
        $sameCategorie = $repoProduct->findByCategorie($categories);

        $commentaire = new Commentaire;

        $commentForm = $this->createForm(CommentaireTypeFormType::class, $commentaire);

        $commentForm->handleRequest($request);

        if($commentForm->isSubmitted() && $commentForm->isValid())
        {
            $user = $this->getUser();

            $commentaire->setDate(new \DateTime())
                    ->setAuteur($user->getPrenom() . ' ' . $user->getNom())
                    ->setProduit($produit);

            // dd($comment);

            $manager->persist($commentaire);
            $manager->flush();

            $this->addFlash('success', "Félicitations ! Votre commentaire a bien été posté !");

            return $this->redirectToRoute('fiche_produit', [
                'id' => $produit->getId()
            ]);
        }

        return $this->render('base/fiche_produit.html.twig', [
            'produit' => $produit,
            'sameCategorie' => $sameCategorie,
            'commentaireForm' => $commentForm->createView()
        ]);
    }

    #[Route('/contact', name: 'contact')]
    public function fichecontact(): Response
    {
        return $this->render('base/contact.html.twig');
    }

    #[Route('/faq', name: 'faq')]
    public function fichefaq(): Response
    {
        return $this->render('base/faq.html.twig');
    }


    #[Route('/profil', name: 'profil')]
    public function pageProfil(): Response
    {
        return $this->render('base/profil.html.twig');
    }

    #[Route('/legal_notice', name: 'legal_notice')]
    public function pageNotice(): Response
    {
        return $this->render('base/legal_notice.html.twig');
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
  
        return $this->render('base/panier.html.twig', [
            'panier' => $panier
        ]);
    }

    #[Route('artiste/{id}', name: 'profil_vendeur')]
    public function mon_profil(User $user): Response 
    {
        if(!in_array('ROLE_VENDEUR' ,$user->getRoles()))
        {
            return $this->redirectToRoute('nos_artistes');
        }

        return $this->render('base/profil_vendeur.html.twig', [
            'vendeur' => $user
        ]);
    }

    #[Route('mescommandes/{id}', name: 'ma_commande')]
    public function ma_commande(Commande $commande, ProduitRepository $repoProduit, FormatRepository $repoFormat): Response 
    {
        $user = $this->getUser();
        if($user->getId() != $commande->getUser()->getId())
        {
            return $this->redirectToRoute('profil');
        }

        $articles = array();
        foreach($commande->getDetailsCommandes() as $details)
        {
            $article['produit'] = $repoProduit->find($details->getProduitId());
            $article['format'] = $repoFormat->find($details->getFormatId());
            $article['quantite'] = $details->getQuantite();
            $article['prix'] = $details->getPrix();
            array_push($articles, $article);
        }

        return $this->render('base/ma_commande.html.twig', [
            'commande' => $commande,
            'articles' => $articles
        ]);
    }
    
}
