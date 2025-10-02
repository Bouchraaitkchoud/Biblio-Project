<?php

namespace App\Form;

use App\Entity\Book;
use App\Entity\Discipline;
use App\Entity\Author;
use App\Entity\Publisher;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\IntegerType;
use Symfony\Component\Form\Extension\Core\Type\FileType;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class BookType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('title', TextType::class, [
                'label' => 'Title',
                'required' => true
            ])
            ->add('discipline', EntityType::class, [
                'class' => Discipline::class,
                'choice_label' => 'name',
                'label' => 'Discipline',
                'required' => true
            ])
            ->add('publicationYear', IntegerType::class, [
                'label' => 'Publication Year',
                'required' => false
            ])
            ->add('isbn', TextType::class, [
                'label' => 'ISBN',
                'required' => false
            ])
            ->add('authors', EntityType::class, [
                'class' => Author::class,
                'choice_label' => 'name',
                'label' => 'Authors',
                'multiple' => true,
                'expanded' => false,
                'required' => true
            ])
            ->add('publishers', EntityType::class, [
                'class' => Publisher::class,
                'choice_label' => 'name',
                'label' => 'Publishers',
                'multiple' => true,
                'expanded' => false,
                'required' => false
            ])
            ->add('coverImage', FileType::class, [
                'label' => 'Cover Image',
                'required' => false,
                'mapped' => false
            ])
            ->add('description', TextType::class, [
                'label' => 'Description',
                'required' => false
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