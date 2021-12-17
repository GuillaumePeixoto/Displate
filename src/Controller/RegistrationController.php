<?php

namespace App\Controller;

use App\Entity\User;
use App\Form\RegistrationFormType;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;

class RegistrationController extends AbstractController
{
    #[Route('/register', name: 'app_register')]
    public function register(Request $request, UserPasswordHasherInterface $userPasswordHasher, EntityManagerInterface $entityManager): Response
    {
        if($this->getUser())
        {
            return $this->redirectToRoute('home');
        }
        $user = new User();


        $form = $this->createForm(RegistrationFormType::class, $user, [
            'userRegistration' => true 
        ]); 
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid())
        {
            $hash =$userPasswordHasher->hashPassword(
                $user,
                $form->get('password')->getData()
                
            );
            $user->setPassword($hash);

            $this->addFlash('success', "Félicitations ! Vous êtes bien inscrit sur le site");

            $entityManager->persist($user);
            $entityManager->flush();
    
            return $this->redirectToRoute('home');
        }

        return $this->render('registration/register.html.twig', [
            'registrationForm' => $form->createView(),
        ]);
    }

}
