<?php

namespace App\Controller;

use App\Entity\Lecteur;
use App\Entity\Order;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/mon-compte')]
#[IsGranted('ROLE_USER')]
class ProfileController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('', name: 'profile_index', methods: ['GET'])]
    public function index(): Response
    {
        $user = $this->getUser();
        
        // If user is an admin (not a Lecteur), redirect to admin dashboard
        if (!$user instanceof Lecteur) {
            return $this->redirectToRoute('admin_dashboard');
        }

        /** @var Lecteur $lecteur */
        $lecteur = $user;

        return $this->render('profile/index.html.twig', [
            'lecteur' => $lecteur,
        ]);
    }

    #[Route('/changer-mot-de-passe', name: 'profile_change_password', methods: ['GET', 'POST'])]
    public function changePassword(
        Request $request,
        UserPasswordHasherInterface $passwordHasher
    ): Response {
        $user = $this->getUser();
        
        // If user is an admin (not a Lecteur), redirect to admin dashboard
        if (!$user instanceof Lecteur) {
            return $this->redirectToRoute('admin_dashboard');
        }

        /** @var Lecteur $lecteur */
        $lecteur = $user;

        if ($request->isMethod('POST')) {
            $currentPassword = $request->request->get('current_password');
            $newPassword = $request->request->get('new_password');
            $confirmPassword = $request->request->get('confirm_password');

            // Validation
            $errors = [];

            // For Lecteur with plaintext password, we just compare directly
            if ($lecteur->getPassword() !== $currentPassword) {
                $errors[] = 'Le mot de passe actuel est incorrect.';
            }

            if (strlen($newPassword) < 6) {
                $errors[] = 'Le nouveau mot de passe doit contenir au moins 6 caractères.';
            }

            if ($newPassword !== $confirmPassword) {
                $errors[] = 'Les mots de passe ne correspondent pas.';
            }

            if (empty($errors)) {
                // For Lecteur, we use plaintext (as configured in security.yaml)
                $lecteur->setPassword($newPassword);
                
                // Remove force password change flag
                $lecteur->setForcePasswordChange(false);
                
                $this->entityManager->flush();

                $this->addFlash('success', 'Votre mot de passe a été modifié avec succès.');
                return $this->redirectToRoute('profile_index');
            }

            foreach ($errors as $error) {
                $this->addFlash('error', $error);
            }
        }

        return $this->render('profile/change_password.html.twig', [
            'lecteur' => $lecteur,
            'mustChangePassword' => $lecteur->getForcePasswordChange(),
        ]);
    }

    #[Route('/commandes', name: 'profile_commandes', methods: ['GET'])]
    #[IsGranted('IS_AUTHENTICATED_FULLY')]
    public function commandes(): Response
    {
        /** @var Lecteur $lecteur */
        $lecteur = $this->getUser();
        
        // If user is an admin (not a Lecteur), redirect to admin dashboard
        if (!$lecteur instanceof Lecteur) {
            return $this->redirectToRoute('admin_dashboard');
        }
        
        // Fetch all approved orders for this lecteur
        $orders = $this->entityManager->getRepository(Order::class)
            ->createQueryBuilder('o')
            ->leftJoin('o.items', 'oi')
            ->leftJoin('oi.exemplaire', 'e')
            ->leftJoin('e.book', 'b')
            ->leftJoin('b.authors', 'a')
            ->addSelect('oi', 'e', 'b', 'a')
            ->where('o.lecteur = :lecteur')
            ->andWhere('o.status = :status')
            ->setParameter('lecteur', $lecteur)
            ->setParameter('status', 'approved')
            ->orderBy('o.placedAt', 'DESC')
            ->getQuery()
            ->getResult();
        
        return $this->render('profile/commandes.html.twig', [
            'orders' => $orders,
            'lecteur' => $lecteur
        ]);
    }
}
