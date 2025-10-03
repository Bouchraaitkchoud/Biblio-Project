<?php

namespace App\Form;

use App\Entity\Book;
use App\Entity\Discipline;
use App\Entity\Author;
use App\Entity\Publisher;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\TextareaType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints\File;

class BookType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title', TextType::class, [
                'label' => 'Titre',
                'required' => true,
                'attr' => [
                    'placeholder' => 'Saisir le titre du livre',
                    'class' => 'form-control'
                ]
            ])
            ->add('discipline', EntityType::class, [
                'class' => Discipline::class,
                'choice_label' => 'name',
                'label' => 'Discipline',
                'required' => true,
                'placeholder' => 'Sélectionner une discipline',
                'attr' => ['class' => 'form-select']
            ])
            ->add('authors', EntityType::class, [
                'class' => Author::class,
                'choice_label' => 'name',
                'label' => 'Auteurs',
                'multiple' => true,
                'expanded' => false,
                'required' => true,
                'attr' => ['class' => 'form-select select2-multiple']
            ])
            ->add('publishers', EntityType::class, [
                'class' => Publisher::class,
                'choice_label' => 'name',
                'label' => 'Éditeurs',
                'multiple' => true,
                'expanded' => false,
                'required' => false,
                'attr' => ['class' => 'form-select select2-multiple']
            ])
            ->add('publicationYear', IntegerType::class, [
                'label' => 'Année de publication',
                'required' => false,
                'attr' => [
                    'placeholder' => 'ex: 2023',
                    'class' => 'form-control',
                    'min' => 1800,
                    'max' => (int)date('Y') + 2
                ]
            ])
            ->add('isbn', TextType::class, [
                'label' => 'ISBN',
                'required' => false,
                'attr' => [
                    'placeholder' => 'e.g., 978-3-16-148410-0',
                    'class' => 'form-control'
                ]
            ])
            ->add('description', TextareaType::class, [
                'label' => 'Description',
                'required' => false,
                'attr' => [
                    'rows' => 4,
                    'placeholder' => 'Saisir une description détaillée du livre...',
                    'class' => 'form-control'
                ]
            ])
            ->add('coverImage', FileType::class, [
                'label' => 'Image de couverture',
                'required' => false,
                'mapped' => false,
                'constraints' => [
                    new File([
                        'maxSize' => '5M',
                        'mimeTypes' => [
                            'image/jpeg',
                            'image/jpg',
                            'image/png',
                            'image/gif',
                        ],
                        'mimeTypesMessage' => 'Please upload a valid image file (JPG, PNG, GIF)',
                    ])
                ],
                'attr' => [
                    'accept' => 'image/*',
                    'class' => 'form-control'
                ]
            ])
            ->add('edition', TextType::class, [
                'label' => 'Édition',
                'required' => false,
                'attr' => [
                    'placeholder' => 'ex: 3ème édition',
                    'class' => 'form-control'
                ]
            ])
            ->add('price', TextType::class, [
                'label' => 'Prix (€)',
                'required' => false,
                'attr' => [
                    'placeholder' => 'ex: 29.99',
                    'class' => 'form-control'
                ]
            ])
            ->add('acquisitionMode', ChoiceType::class, [
                'label' => 'Mode d\'acquisition',
                'required' => false,
                'choices' => [
                    'Achat' => 'achat',
                    'Don' => 'don',
                    'Échange' => 'echange',
                    'Cadeau' => 'cadeau',
                    'Prêt' => 'pret'
                ],
                'placeholder' => 'Sélectionner le mode d\'acquisition',
                'attr' => ['class' => 'form-select']
            ])
            ->add('acquisitionDate', DateType::class, [
                'label' => 'Date d\'acquisition',
                'required' => false,
                'widget' => 'single_text',
                'attr' => ['class' => 'form-control']
            ])
            ->add('documentType', ChoiceType::class, [
                'label' => 'Type de document',
                'required' => false,
                'choices' => [
                    'Ouvrage' => 'ouvrage',
                    'Thèse' => 'these',
                    'Document numérique' => 'document_numerique',
                    'Manuel' => 'manuel',
                    'Revue scientifique' => 'revue_scientifique',
                    'Magazine' => 'magazine',
                    'Mémoire' => 'memoire',
                    'Rapport de stage' => 'rapport_stage',
                    'Article' => 'article',
                    'Dictionnaire' => 'dictionnaire',
                    'Encyclopédie' => 'encyclopedie',
                    'Atlas' => 'atlas',
                    'Guide pratique' => 'guide_pratique',
                    'Cours magistral' => 'cours_magistral',
                    'Polycopié' => 'polycopie'
                ],
                'placeholder' => 'Sélectionner le type de document',
                'attr' => ['class' => 'form-select']
            ])
            ->add('location', TextType::class, [
                'label' => 'Localisation dans la bibliothèque',
                'required' => true,
                'attr' => [
                    'placeholder' => 'ex: A-12-3, Section B, Étage 2',
                    'class' => 'form-control'
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Book::class,
        ]);
    }
} 