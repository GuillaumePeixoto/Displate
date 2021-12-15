<?php

namespace App\Form;

use App\Entity\Produit;
use Symfony\Component\Validator\Constraints\File;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;

class ProduitFormType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('photo', FileType::class, [
                'label' => "Uploader une photo",
                'mapped' => true,
                'required' => false,
                'data_class' => null,
                'constraints' => [
                    new File([
                        'maxSize' => '5M',
                        'mimeTypes' => [
                            'image/jpeg',
                            'image/png',
                            'image/jpg'
                        ],
                        'mimeTypesMessage' => "Formats autorisé : jpeg, png, jpg."
                    ])
                ]
            ])
            ->add('titre', TextType::class, [
                'label' => "Titre de l'article",
                'required' => false,
                'attr' => ["placeholder" => "Saisir le titre du produit"],
                'constraints' => [
                    new Length([
                        'min' => 10,
                        'max' => 50,
                        'minMessage' => "Titre trop court (min 10 caractères)",
                        'maxMessage' => "Titre trop long (max 50 caractères)"
                    ]),
                    new NotBlank([
                        'message' => "Merci de saisir un titre."
                    ])
                ]
            ])
            ->add('description', TextareaType::class, [
                'required' => false,
                'attr' => [
                    'placeholder' => "Saisir une description du produit",
                    'rows' => "10"
                ],
                'constraints' => [
                    new NotBlank([
                        'message' => "Merci de saisir une description."
                    ])
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Produit::class,
        ]);
    }
}
