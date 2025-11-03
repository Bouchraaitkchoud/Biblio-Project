<?php

namespace App\Form;

use App\Entity\Exemplaire;
use App\Entity\Location;
use Symfony\Bridge\Doctrine\Form\Type\EntityType;
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
                'label' => 'Code-barres',
                'required' => true
            ])
            ->add('location', EntityType::class, [
                'class' => Location::class,
                'choice_label' => 'name',
                'label' => 'Emplacement',
                'required' => false,
                'placeholder' => 'Sélectionner un emplacement'
            ])
            ->add('acquisition_mode', ChoiceType::class, [
                'choices' => [
                    'Achat' => 'achat',
                    'Don' => 'don',
                    'Échange' => 'echange',
                ],
                'label' => 'Mode d\'acquisition',
                'required' => false,
                'placeholder' => 'Sélectionner un mode'
            ])
            ->add('acquisition_date', DateType::class, [
                'label' => 'Date d\'acquisition',
                'required' => false,
                'widget' => 'single_text'
            ])
            ->add('price', NumberType::class, [
                'label' => 'Prix',
                'required' => false,
                'scale' => 2
            ])
            ->add('status', ChoiceType::class, [
                'choices' => [
                    'Disponible' => 'available',
                    'Emprunté' => 'borrowed',
                    'Maintenance' => 'maintenance',
                    'Perdu' => 'lost'
                ],
                'label' => 'Statut',
                'required' => false
            ])
            ->add('comment', TextType::class, [
                'label' => 'Commentaire',
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
