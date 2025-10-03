<?php

namespace App\Form;

use App\Entity\Discipline;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\Length;
use Symfony\Component\Validator\Constraints\NotBlank;
use Symfony\Component\Validator\Constraints\File;

class DisciplineType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('name', TextType::class, [
                'label' => 'Nom de la discipline',
                'attr' => [
                    'class' => 'form-control',
                    'placeholder' => 'Entrez le nom de la discipline'
                ],
                'constraints' => [
                    new NotBlank([
                        'message' => 'Le nom de la discipline ne peut pas être vide'
                    ]),
                    new Length([
                        'min' => 2,
                        'max' => 255,
                        'minMessage' => 'Le nom doit contenir au moins {{ limit }} caractères',
                        'maxMessage' => 'Le nom ne peut pas dépasser {{ limit }} caractères'
                    ])
                ]
            ])
            ->add('image', FileType::class, [
                'label' => 'Image de la discipline',
                'required' => false,
                'mapped' => false, // N'est pas mappé directement à l'entité
                'attr' => [
                    'class' => 'form-control',
                    'accept' => 'image/*'
                ],
                'help' => 'Formats acceptés: JPG, PNG, GIF. Taille max: 5MB. Laissez vide pour utiliser l\'icône automatique.',
                'constraints' => [
                    new File([
                        'maxSize' => '5M',
                        'mimeTypes' => [
                            'image/jpeg',
                            'image/png',
                            'image/gif',
                            'image/webp',
                        ],
                        'mimeTypesMessage' => 'Veuillez télécharger une image valide (JPG, PNG, GIF, WebP)',
                        'maxSizeMessage' => 'L\'image ne doit pas dépasser 5MB'
                    ])
                ]
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Discipline::class,
        ]);
    }
}