<?php

namespace App\Form;

use App\Entity\Exemplaire;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\Extension\Core\Type\ChoiceType;
use Symfony\Component\Form\Extension\Core\Type\DateType;
use Symfony\Component\Form\Extension\Core\Type\NumberType;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\OptionsResolver\OptionsResolver;

class ExemplaireType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('barcode', TextType::class, [
                'label' => 'Barcode',
                'required' => true
            ])
            ->add('section_id', NumberType::class, [
                'label' => 'Section ID',
                'required' => false
            ])
            ->add('status', ChoiceType::class, [
                'choices' => [
                    'Available' => 'available',
                    'Borrowed' => 'borrowed',
                    'Maintenance' => 'maintenance'
                ],
                'label' => 'Status'
            ])
            ->add('locationId', TextType::class, [
                'label' => 'Location ID',
                'required' => false
            ])
            ->add('callNumber', TextType::class, [
                'label' => 'Call Number',
                'required' => false
            ])
            ->add('acquisitionDate', DateType::class, [
                'label' => 'Acquisition Date',
                'required' => false,
                'widget' => 'single_text'
            ])
            ->add('returnDate', DateType::class, [
                'label' => 'Return Date',
                'required' => false,
                'widget' => 'single_text'
            ])
            ->add('price', NumberType::class, [
                'label' => 'Price',
                'required' => false,
                'scale' => 2
            ])
            ->add('comment', TextType::class, [
                'label' => 'Comment',
                'required' => false
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