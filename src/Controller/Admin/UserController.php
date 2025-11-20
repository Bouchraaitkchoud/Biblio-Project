<?php

namespace App\Controller\Admin;

use App\Entity\User;
use App\Entity\Section;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\PasswordHasher\Hasher\UserPasswordHasherInterface;
use Symfony\Component\HttpFoundation\Exception\BadRequestException;

#[Route('/admin/users')]
#[IsGranted('ROLE_ADMIN')]
class UserController extends AbstractController
{
    public function __construct(private EntityManagerInterface $entityManager) {}

    #[Route('/', name: 'admin_users_index', methods: ['GET'])]
    public function index(Request $request): Response
    {
        $search = trim($request->query->get('search', ''));
        $userRepo = $this->entityManager->getRepository(User::class);

        // Only get admin users (exclude regular ROLE_USER only)
        $qb = $userRepo->createQueryBuilder('u');

        if ($search !== '') {
            $searchLower = strtolower($search);
            $qb->where('LOWER(u.email) LIKE :search OR LOWER(u.login) LIKE :search OR LOWER(u.nom) LIKE :search OR LOWER(u.prenom) LIKE :search')
                ->setParameter('search', '%' . $searchLower . '%');
        }

        $users = $qb->getQuery()->getResult();

        // Filter to only show admin users
        $adminUsers = array_filter($users, function ($user) {
            $roles = $user->getRoles();
            return in_array('ROLE_ADMIN', $roles) || in_array('ROLE_LIMITED_ADMIN', $roles);
        });

        return $this->render('admin/users/index.html.twig', [
            'users' => $adminUsers,
        ]);
    }

    #[Route('/new', name: 'admin_user_new', methods: ['GET', 'POST'])]
    public function new(Request $request, UserPasswordHasherInterface $passwordHasher): Response
    {
        // Redirect to admin creation page
        return $this->redirectToRoute('admin_users_new_admin');
    }

    // NEW ACTION: for creating an admin user.
    #[Route('/new/admin', name: 'admin_users_new_admin', methods: ['GET', 'POST'])]
    public function newAdmin(Request $request, UserPasswordHasherInterface $passwordHasher): Response
    {
        $user = new User();

        $privileges = [
            'Gérer les auteurs',
            'Gérer les lecteurs',
            'Gérer les livres',
            'Gérer les retours',
            'Gérer les éditeurs',
            'Gérer les disciplines',
            'Gérer les commandes'
        ];

        if ($request->isMethod('POST')) {
            $userType = $request->request->get('user_type', 'normal');
            $login = $request->request->get('login');
            $nom = $request->request->get('nom');
            $prenom = $request->request->get('prenom');
            $password = $request->request->get('password');
            $confirmPassword = $request->request->get('confirm_password');

            // Validate fields...
            if ($password !== $confirmPassword) {
                $this->addFlash('error', 'Les mots de passe ne correspondent pas.');
                return $this->redirectToRoute('admin_user_new');
            }

            $user = new User();
            $user->setLogin($login);
            $user->setNom($nom);
            $user->setPrenom($prenom);
            $user->setEmail($login . '@admin.com');
            // Set password hashed, etc.
            $user->setPassword($passwordHasher->hashPassword($user, $password));

            if ($userType === 'absolute') {
                // Absolute admin: full access
                $user->setRoles(['ROLE_ADMIN', 'ROLE_USER']);
            } elseif ($userType === 'limited') {
                // Limited admin: permissions are already sent as ROLE_XXX from checkboxes
                $selectedRoles = $request->request->all('privileges') ?? [];
                // Merge base LIMITED_ADMIN role with selected permissions
                $roles = array_merge(['ROLE_LIMITED_ADMIN', 'ROLE_USER'], $selectedRoles);
                $user->setRoles($roles);
            } else {
                // Normal user: assign standard user role
                $user->setRoles(['ROLE_USER']);
            }

            // Save user
            $this->entityManager->persist($user);
            $this->entityManager->flush();

            $this->addFlash('success', 'Administrateur créé avec succès.');
            return $this->redirectToRoute('admin_users_index');
        }

        return $this->render('admin/users/new_admin.html.twig', [
            'privileges' => $privileges,
        ]);
    }

    #[Route('/{id<\d+>}', name: 'admin_user_show', methods: ['GET'])]
    public function show($id): Response
    {
        $user = $this->entityManager->getRepository(User::class)->find($id);
        if (!$user) {
            throw $this->createNotFoundException('User not found');
        }
        return $this->render('admin/user/show.html.twig', [
            'user' => $user,
        ]);
    }

    #[Route('/{id}/edit', name: 'admin_user_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, User $user, UserPasswordHasherInterface $passwordHasher): Response
    {
        if ($request->isMethod('POST')) {
            $nom = $request->request->get('nom');
            $prenom = $request->request->get('prenom');
            $email = $request->request->get('email');
            $password = $request->request->get('password');
            $adminType = $request->request->get('admin_type');
            $selectedPermissions = $request->request->all('permissions') ?? [];

            // Validation
            if (empty($nom) || empty($prenom) || empty($email)) {
                $this->addFlash('error', 'Nom, prénom et email sont requis.');
                return $this->render('admin/users/edit.html.twig', ['user' => $user]);
            }

            // Update basic info
            $user->setNom($nom);
            $user->setPrenom($prenom);
            $user->setEmail($email);

            // Update password if provided
            if (!empty($password)) {
                $hashedPassword = $passwordHasher->hashPassword($user, $password);
                $user->setPassword($hashedPassword);
            }

            // Set roles based on admin type
            if ($adminType === 'absolute') {
                $user->setRoles(['ROLE_ADMIN', 'ROLE_USER']);
            } elseif ($adminType === 'limited') {
                $roles = array_merge(['ROLE_LIMITED_ADMIN', 'ROLE_USER'], $selectedPermissions);
                $user->setRoles($roles);
            } else {
                $user->setRoles(['ROLE_USER']);
            }

            $this->entityManager->flush();
            $this->addFlash('success', 'Administrateur modifié avec succès.');
            return $this->redirectToRoute('admin_users_index');
        }

        return $this->render('admin/users/edit.html.twig', [
            'user' => $user,
        ]);
    }

    #[Route('/{id}/delete', name: 'admin_user_delete', methods: ['POST'])]
    public function delete(Request $request, User $user): Response
    {
        // Only ROLE_ADMIN can delete (not limited admins)
        if (!$this->isGranted('ROLE_ADMIN')) {
            $this->addFlash('error', 'Vous n\'avez pas la permission de supprimer des utilisateurs.');
            return $this->redirectToRoute('admin_users_index');
        }

        if ($this->isCsrfTokenValid('delete' . $user->getId(), $request->request->get('_token'))) {
            $this->entityManager->remove($user);
            $this->entityManager->flush();

            $this->addFlash('success', 'User deleted successfully.');
        }
        return $this->redirectToRoute('admin_users_index');
    }

    // CSV export action for users
    #[Route('/export-csv', name: 'admin_users_export_csv', methods: ['GET'])]
    public function exportCsv(): Response
    {
        $users = $this->entityManager->getRepository(User::class)->findAll();

        // Build CSV header
        $csvData = "ID,Nom,Prénom,Login,Email,Rôles\n";
        foreach ($users as $user) {
            $id       = $user->getId();
            $nom      = str_replace([",", "\n"], [" ", " "], $user->getNom());
            $prenom   = str_replace([",", "\n"], [" ", " "], $user->getPrenom());
            $login    = str_replace([",", "\n"], [" ", " "], $user->getLogin());
            $email    = str_replace([",", "\n"], [" ", " "], $user->getEmail());
            $roles    = is_array($user->getRoles()) ? implode('|', $user->getRoles()) : '';

            $csvData .= sprintf("%d,%s,%s,%s,%s,%s\n", $id, $nom, $prenom, $login, $email, $roles);
        }

        $response = new Response($csvData);
        $disposition = $response->headers->makeDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            'users.csv'
        );
        $response->headers->set('Content-Disposition', $disposition);
        $response->headers->set('Content-Type', 'text/csv');

        return $response;
    }

    // Example of checking privilege in a controller method
    public function someAction()
    {
        if ($this->isGranted('PRIVILEGE_GERER_LES_AUTEURS')) {
            // Allow access to the "Gérer les auteurs" section.
        } else {
            // Deny access or show an error message.
        }
    }
}
