<?php

namespace App\Form;

use App\Entity\Exemplaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ExemplaireType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('barcode', TextType::class, [
                'label' => 'Barcode',
                'required' => true,
                'attr' => [
                    'placeholder' => 'Enter barcode',
                    'class' => 'form-control'
                ]
            ])
            ->add('section_id', NumberType::class, [
                'label' => 'Section ID',
                'required' => false,
                'attr' => [
                    'placeholder' => 'Enter section ID',
                    'class' => 'form-control'
                ]
            ])
            ->add('status', ChoiceType::class, [
                'label' => 'Status',
                'required' => true,
                'choices' => [
                    'Available' => 'available',
                    'Borrowed' => 'borrowed',
                    'Maintenance' => 'maintenance'
                ],
                'attr' => [
                    'class' => 'form-control'
                ]
            ])
            ->add('location_id', NumberType::class, [
                'label' => 'Location ID',
                'required' => false,
                'attr' => [
                    'placeholder' => 'Enter location ID',
                    'class' => 'form-control'
                ]
            ])
            ->add('call_number', TextType::class, [
                'label' => 'Call Number',
                'required' => false,
                'attr' => [
                    'placeholder' => 'Enter call number',
                    'class' => 'form-control'
                ]
            ])
            ->add('acquisition_date', DateType::class, [
                'label' => 'Acquisition Date',
                'required' => true,
                'widget' => 'single_text',
                'attr' => [
                    'class' => 'form-control'
                ]
            ])
            ->add('price', NumberType::class, [
                'label' => 'Price',
                'required' => false,
                'scale' => 2,
                'attr' => [
                    'placeholder' => 'Enter price',
                    'class' => 'form-control'
                ]
            ])
            ->add('comment', TextType::class, [
                'label' => 'Comment',
                'required' => false,
                'attr' => [
                    'placeholder' => 'Enter comment',
                    'class' => 'form-control'
                ]
            ])
        ;
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Exemplaire::class,
        ]);
    }
} 