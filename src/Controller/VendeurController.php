<?php

namespace App\Controller;

use App\Entity\Produit;
use App\Entity\User;
use App\Form\ProduitFormType;
use App\Form\RegistrationFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\Session\Session;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

class VendeurController extends AbstractController
{
    #[Route('/vendeur', name: 'vendeur')]
    public function index(): Response
    {
        return $this->render('vendeur/index.html.twig', [
            'controller_name' => 'VendeurController',
        ]);
    }

    #[Route('vendeur/profil/', name: 'mon_profil')]
    public function mon_profil(): Response
    {
        return $this->render('vendeur/artiste.html.twig');
    }


    #[Route('/vendeur/{id}/edit', name: 'edit_vendeur')]
    public function editProfil(User $user , EntityManagerInterface $manager, Request $request, SluggerInterface $slugger): Response
    {

        $ProfilBdd = $user->getImageProfil();
        $banniereBdd = $user->getBanniereProfil();
        $vendeurForm = $this->createForm(RegistrationFormType::class, $user, ['vendeurUpdate' => true]);
    
       
        $vendeurForm->handleRequest($request);
    

        if ($vendeurForm->isSubmitted() && $vendeurForm->isValid()) {
            // encode the plain password

            $profilphoto = $vendeurForm->get('imageProfil')->getData();
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

            $banniere = $vendeurForm->get('banniereProfil')->getData();
            if($banniere)
            {
                $nomOriginePhoto = pathinfo($banniere->getClientOriginalName(), PATHINFO_FILENAME);
                //dd($nomOriginePhoto);

                // cela est necessaire pour inclure en toute sécurité le nom du fichier dans l'URL
                $secureNomPhoto = $slugger->slug($nomOriginePhoto);

                $nouveauNomFichier = $secureNomPhoto.' - '.uniqid().'.'.$banniere->guessExtension();
                // dd($nouveauNomFichier);
                try
                {
                    $banniere->move(
                        $this->getParameter('photo_directory'),
                        $nouveauNomFichier
                    );
                }
                catch(FileException $e)
                {

                }

                $user->setBanniereProfil($nouveauNomFichier);

            }
            else
            {
                $user->setBanniereProfil($banniereBdd);                    
            }
            

            $manager->persist($user);
            $manager->flush();

            return $this->redirectToRoute('vendeur');
        }

        return $this->render('vendeur/edit_profil.html.twig', [
            'vendeurForm' => $vendeurForm->createView(),
            'photoBdd' => $ProfilBdd,
            'banniereBdd' => $banniereBdd
        ]);
    }

    #[Route('/vendeur/presentation', name: 'presentation')]
    public function presentation(): Response
    {
        return $this->render('vendeur/presentation.html.twig');
    }

    #[Route('/vendeur/produit/{id}/remove', name: 'vendeur_remove_produit')]
    public function showProduit(EntityManagerInterface $manager, Produit $produit): Response
    {


        $titre = $produit->getTitre();

        $manager->remove($produit);
        $manager->flush();

        $this->addFlash('success', "Le produit $titre a été supprimer avec succès !");
        return $this->redirectToRoute('vendeur');

    }


    #[Route('/vendeur/produit/new', name: 'create_produit_vendeur')]
    #[Route('/vendeur/produit/{id}/modify', name: 'modify_produit_vendeur')]
    public function produitForm(Produit $produit = null, EntityManagerInterface $manager, Request $request, SluggerInterface $slugger): Response
    {
        if($produit)
        {
            $photoBdd = $produit->getPhoto();
            $action = "Modification";
            $produitForm = $this->createForm(ProduitFormType::class, $produit, ['modifyProduit' => true]);
        }
        else
        {
            $produit = new Produit();
            $action = "Ajout";
            $produitForm = $this->createForm(ProduitFormType::class, $produit, ['newProduit' => true]);
        }
        
       
        $produitForm->handleRequest($request);
    

        if ($produitForm->isSubmitted() && $produitForm->isValid()) {
            // encode the plain password



            if($action == 'Ajout')
            {

                $produit->setUser($this->getUser());
                $photo = $produitForm->get('photo')->getData();
                if($photo)
                {
                    $nomOriginePhoto = pathinfo($photo->getClientOriginalName(), PATHINFO_FILENAME);
                    //dd($nomOriginePhoto);

                    // cela est necessaire pour inclure en toute sécurité le nom du fichier dans l'URL
                    $secureNomPhoto = $slugger->slug($nomOriginePhoto);

                    $nouveauNomFichier = $secureNomPhoto.' - '.uniqid().'.'.$photo->guessExtension();
                    // dd($nouveauNomFichier);
                    try
                    {
                        $photo->move(
                            $this->getParameter('photo_directory'),
                            $nouveauNomFichier
                        );
                    }
                    catch(FileException $e)
                    {

                    }

                    $produit->setPhoto($nouveauNomFichier);

                }
                else
                {
                    $produit->setPhoto($photoBdd);                    
                }
                
            }

            $manager->persist($produit);
            $manager->flush();

            return $this->redirectToRoute('vendeur');
        }
        // 'formUserUpdate' => ($request->query->get('op') == 'update') ? $formUserUpdate->createView() : '',
        return $this->render('vendeur/produit_form.html.twig',[
            'produitForm' => $produitForm->createView(),
            'photoActuel' => !empty($photoBdd) ? $photoBdd : "",
            'action' => $action,
        ]);
    }
}
