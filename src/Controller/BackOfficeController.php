<?php

namespace App\Controller;

use App\Entity\Categorie;
use App\Entity\Commentaire;
use App\Entity\Format;
use App\Entity\Produit;
use App\Entity\User;
use App\Form\CategorieTypeFormType;
use App\Form\FormatFormType;
use App\Form\ProduitFormType;
use App\Form\RegistrationFormType;
use App\Repository\CategorieRepository;
use App\Repository\CommentaireRepository;
use App\Repository\FormatRepository;
use App\Repository\ProduitRepository;
use App\Repository\UserRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\String\Slugger\SluggerInterface;

class BackOfficeController extends AbstractController
{
    #[Route('/backoffice', name: 'back_office')]
    public function index(): Response
    {
        return $this->render('back_office/index.html.twig', [
            'controller_name' => 'BackOfficeController',
        ]);
    }

    #[Route('/backoffice/users', name: 'show_users')]
    #[Route('/backoffice/user/{id}/remove', name: 'remove_user')]
    public function showUsers(UserRepository $repoUsers, EntityManagerInterface $manager, User $user = null): Response
    {

        if($user)
        {
            $nom = $user->getNom();
            $prenom = $user->getPrenom();

            $manager->remove($user);
            $manager->flush();

            $this->addFlash('success', "L'utilisateur $nom $prenom a été supprimer avec succès !");
            return $this->redirectToRoute('show_users');
        }

        $colonnes = $manager->getClassMetadata(User::class)->getFieldNames();
        $users = $repoUsers->findAll();

        return $this->render('back_office/show_user.html.twig', [
            'users' => $users,
            'colonnes' => $colonnes
        ]);
    }

    #[Route('/backoffice/user/new', name: 'create_user')]
    #[Route('/backoffice/user/{id}/modify', name: 'modify_user')]
    public function userForm(User $user = null, EntityManagerInterface $manager, Request $request, UserPasswordHasherInterface $userPasswordHasher): Response
    {
        if($user)
        {
            $action = "Modification";
            $userForm = $this->createForm(RegistrationFormType::class, $user, [
                'userUpdate' => true 
            ]);
        }
        else
        {
            $user = new User();
            $action = "Ajout";
            $userForm = $this->createForm(RegistrationFormType::class, $user, [
                'userRegistration' => true 
            ]);
        }

        $userForm->handleRequest($request);

        if ($userForm->isSubmitted() && $userForm->isValid()) {
            // encode the plain password
            if($action == 'Ajout')
            {
                $user->setPassword(
                    $userPasswordHasher->hashPassword(
                        $user,
                        $userForm->get('password')->getData()
                    )
                );            
            }


            $manager->persist($user);
            $manager->flush();

            return $this->redirectToRoute('show_users');
        }

        return $this->render('back_office/user_form.html.twig',[
            'userForm' => $userForm->createView(),
            'action' => $action,
        ]);
    }

    #[Route('/backoffice/produits', name: 'show_produits')]
    public function showProduit(ProduitRepository $repoProduit, EntityManagerInterface $manager, Produit $produit = null): Response
    {
        $colonnes = $manager->getClassMetadata(Produit::class)->getFieldNames();
        $produits = $repoProduit->findAll();

        return $this->render('back_office/show_produit.html.twig', [
            'produits' => $produits,
            'colonnes' => $colonnes
        ]);
    }


    #[Route('/backoffice/produit/new', name: 'create_produit')]
    #[Route('/backoffice/produit/{id}/modify', name: 'modify_produit')]
    public function produitForm(Produit $produit = null, EntityManagerInterface $manager, Request $request, SluggerInterface $slugger): Response
    {
        if($produit)
        {
            $photoBdd = $produit->getPhoto();
            $action = "Modification";
        }
        else
        {
            $produit = new Produit();
            $action = "Ajout";
        }

        
        $produitForm = $this->createForm(ProduitFormType::class, $produit);
        $produitForm->handleRequest($request);

        if ($produitForm->isSubmitted() && $produitForm->isValid()) {
            // encode the plain password

            
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


            $manager->persist($produit);
            $manager->flush();

            return $this->redirectToRoute('show_produits');
        }

        return $this->render('back_office/produit_form.html.twig',[
            'produitForm' => $produitForm->createView(),
            'action' => $action,
        ]);
    }

    #[Route('/backoffice/formats', name: 'show_formats')]
    #[Route('/backoffice/format/{id}/remove', name: 'remove_format')]
    public function showFormats(FormatRepository $repoFormats, EntityManagerInterface $manager, Format $format = null): Response
    {

        if($format)
        {
            $titre = $format->getFormat();

            $manager->remove($format);
            $manager->flush();

            $this->addFlash('success', "L'utilisateur $titre été supprimer avec succès !");
            return $this->redirectToRoute('show_formats');
        }

        $colonnes = $manager->getClassMetadata(Format::class)->getFieldNames();
        $formats = $repoFormats->findAll();

        return $this->render('back_office/show_format.html.twig', [
            'formats' => $formats,
            'colonnes' => $colonnes
        ]);
    }

    #[Route('/backoffice/format/new', name: 'create_format')]
    #[Route('/backoffice/format/{id}/modify', name: 'modify_format')]
    public function FormatForm(Format $format = null, EntityManagerInterface $manager, Request $request): Response
    {
        if($format)
        {
            $action = "Modification";
        }
        else
        {
            $format = new Format();
            $action = "Ajout";
        }

        
        $formatForm = $this->createForm(FormatFormType::class, $format);
        $formatForm->handleRequest($request);

        if ($formatForm->isSubmitted() && $formatForm->isValid()) {
            // encode the plain password

            $manager->persist($format);
            $manager->flush();

            return $this->redirectToRoute('show_formats');
        }

        return $this->render('back_office/format_form.html.twig',[
            'formatForm' => $formatForm->createView(),
            'action' => $action,
        ]);
    }

    #[Route('/backoffice/commentaires', name: 'show_commentaire')]
    #[Route('/backoffice/commentaire/{id}/remove', name: 'remove_commentaire')]
    public function adminComment(EntityManagerInterface $manager, CommentaireRepository $repoComment, Commentaire $commentaire = null): Response
    {

        $colonnes = $manager->getClassMetadata(Commentaire::class)->getFieldNames();
        $comments = $repoComment->findAll();

        if($commentaire)
        {
            $id = $commentaire->getId();

            $manager->remove($commentaire);
            $manager->flush();
            $this->addFlash('success', "Le commentaire n°$id a été supprimer avec succès !");

            return $this->redirectToRoute('show_commentaire');
        }

        return $this->render('back_office/show_commentaire.html.twig',[
            'colonnes' => $colonnes,
            'comments' => $comments
        ]);
    }

    #[Route('/admin/categories', name: 'show_categories')]
    #[Route('/admin/categorie/{id}/remove', name: 'remove_categorie')]
    public function adminCategory(EntityManagerInterface $manager, CategorieRepository $repoCategorie, Categorie $categorie = null): Response
    {

        $colonnes = $manager->getClassMetadata(Categorie::class)->getFieldNames();
        $categories = $repoCategorie->findAll();


        if($categorie)
        {
            $titre = $categorie->getTitre();

            // if(count($categorie->getArticles()) == 0)
            // {
                $manager->remove($categorie);
                $manager->flush();
                $this->addFlash('success', "La categorie $titre a été supprimer avec succès !");
            // }
            // else
            // {
            //     $this->addFlash('danger', "Vous ne pouvez pas supprimer cette catégorie tant qu'il reste des articles lié à celle-ci");
            // }



            return $this->redirectToRoute('show_categories');
        }

        return $this->render('back_office/show_categories.html.twig',[
            'colonnes' => $colonnes,
            'categories' => $categories
        ]);
    }

    
    #[Route('/admin/categorie/new', name: 'create_categorie')]
    #[Route('/admin/categorie/{id}/modify', name: 'modify_categorie')]
    public function adminCategoryForm(Categorie $categorie = null, EntityManagerInterface $manager, Request $request): Response
    {
        if($categorie)
        {
            $action = "Modification";
        }
        else
        {
            $categorie = new Categorie;
            $action = "Ajout";
        }

        $categorieForm = $this->createForm(CategorieTypeFormType::class, $categorie);

        $categorieForm->handleRequest($request);

        if($categorieForm->isSubmitted() && $categorieForm->isValid())
        {
            $this->addFlash('success', "$action de la categorie !");

            $manager->persist($categorie);

            $manager->flush();

            return $this->redirectToRoute('show_categories');
        }

        return $this->render('back_office/categorie_form.html.twig',[
            'categorieForm' => $categorieForm->createView(),
            'action' => $action,
        ]);
    }

}
