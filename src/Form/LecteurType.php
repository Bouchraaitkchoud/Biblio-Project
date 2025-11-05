<?php


namespace App\Form;

use App\Entity\Lecteur;
use Symfony\Component\Form\AbstractType;
use Symfony\Component\Form\FormBuilderInterface;
use Symfony\Component\Form\Extension\Core\Type\TextType;
use Symfony\Component\Form\Extension\Core\Type\EmailType;
use Symfony\Component\Form\Extension\Core\Type\PasswordType;
use Symfony\Component\OptionsResolver\OptionsResolver;
use Symfony\Component\Validator\Constraints as Assert;

class LecteurType extends AbstractType
{
    public function buildForm(FormBuilderInterface $builder, array $options): void
    {
        $isEdit = $options['is_edit'];
        
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
                'label' => $isEdit ? 'Nouveau mot de passe' : 'Mot de passe',
                'required' => !$isEdit,
                'mapped' => false,
                'constraints' => $isEdit ? [] : [
                    new Assert\NotBlank(['message' => 'Le mot de passe est obligatoire']),
                    new Assert\Length(['min' => 6, 'minMessage' => 'Le mot de passe doit contenir au moins {{ limit }} caractères'])
                ],
                'attr' => [
                    'placeholder' => $isEdit ? 'Laisser vide pour conserver l\'ancien mot de passe' : 'Minimum 6 caractères'
                ]
            ]);
    }

    public function configureOptions(OptionsResolver $resolver): void
    {
        $resolver->setDefaults([
            'data_class' => Lecteur::class,
            'is_edit' => false,
        ]);
    }
}