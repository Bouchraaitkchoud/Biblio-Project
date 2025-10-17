<?php


namespace App\Form;

use App\Entity\Lecteur;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\OptionsResolver\OptionsResolver;

class LecteurType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $builder
            ->add('nom', TextType::class, [
                'label' => 'Nom'
            ])
            ->add('prenom', TextType::class, [
                'label' => 'Prénom'
            ])
            ->add('codeAdmission', TextType::class, [
                'label' => 'Code d’admission'
            ])
            ->add('etablissement', TextType::class, [
                'label' => 'Établissement'
            ])
            ->add('formation', TextType::class, [
                'label' => 'Formation'
            ])
            ->add('promotion', TextType::class, [
                'label' => 'Promotion'
            ])
            ->add('email', EmailType::class, [
                'label' => 'Adresse Mail'
            ])
            ->add('password', PasswordType::class, [
                'label' => 'Mot de passe'
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Lecteur::class,
        ]);
    }
}