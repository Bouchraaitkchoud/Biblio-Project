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
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

#[Route('/admin/users')]
#[Security("is_granted('ROLE_ADMIN') or is_granted('ROLE_GERER_UTILISATEURS')")]
class UserController extends AbstractController
{
    public function __construct(private EntityManagerInterface $entityManager) {}

    #[Route('/', name: 'admin_users_index', methods: ['GET'])]
    public function index(Request $request): Response
    {
        $search = trim($request->query->get('search', ''));
        $userRepo = $this->entityManager->getRepository(User::class);
        if ($search !== '') {
            $searchLower = strtolower($search);
            $users = $userRepo->createQueryBuilder('u')
                ->where('LOWER(u.email) LIKE :search')
                ->setParameter('search', '%' . $searchLower . '%')
                ->getQuery()
                ->getResult();
        } else {
            $users = $userRepo->findAll();
        }
        return $this->render('admin/users/index.html.twig', [
            'users' => $users,
        ]);
    }

    #[Route('/new', name: 'admin_user_new', methods: ['GET', 'POST'])]
    public function new(Request $request, UserPasswordHasherInterface $passwordHasher): Response
    {
        // This method may be kept for generic "new" actions if needed.
        // Otherwise, redirect to one of the two specialized actions.
        return $this->redirectToRoute('admin_users_new_student');
    }

    // NEW ACTION: for creating a student user.
    #[Route('/new/student', name: 'admin_users_new_student', methods: ['GET', 'POST'])]
    public function newStudent(Request $request, UserPasswordHasherInterface $passwordHasher): Response
    {
        if ($request->isMethod('POST')) {
            $email = $request->request->get('email');
            $password = $request->request->get('password');
            // Student users have their own fields (you can expand on this as needed)
            if (empty($email) || empty($password)) {
                $this->addFlash('error', 'Email et mot de passe requis.');
                return $this->render('admin/users/new_student.html.twig');
            }
            $user = new User();
            $user->setEmail($email);
            // Give default ROLE_USER for a student.
            $user->setRoles(['ROLE_USER']);
            $hashedPassword = $passwordHasher->hashPassword($user, $password);
            $user->setPassword($hashedPassword);
            // Here you can also set additional student-specific fields.

            $this->entityManager->persist($user);
            $this->entityManager->flush();

            $this->addFlash('success', 'Utilisateur étudiant créé avec succès.');
            return $this->redirectToRoute('admin_users_index');
        }
        return $this->render('admin/users/new_student.html.twig');
    }

    // NEW ACTION: for creating an admin user.
    #[Route('/new/admin', name: 'admin_users_new_admin', methods: ['GET', 'POST'])]
    public function newAdmin(Request $request, UserPasswordHasherInterface $passwordHasher): Response
    {
        $user = new User();

        $privileges = [
            'Gérer les auteurs',
            'Gérer les utilisateurs',
            'Gérer les livres',
            'Gérer les emprunts',
            'Gérer les retours',
            'Voir les statistiques',
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
                // Limited admin: assign a base limited role and extra roles from privileges
                $privilegeRoleMap = [
                    'Gérer les auteurs'       => 'ROLE_GERER_AUTEURS',
                    'Gérer les utilisateurs'  => 'ROLE_GERER_UTILISATEURS',
                    'Gérer les livres'        => 'ROLE_GERER_LIVRES',
                    'Gérer les retours'       => 'ROLE_GERER_RETOURS',
                    'Gérer les éditeurs'      => 'ROLE_GERER_EDITEURS',
                    'Gérer les disciplines'   => 'ROLE_GERER_DISCIPLINES',
                    'Gérer les commandes'     => 'ROLE_GERER_COMMANDES'
                ];

                $selectedPrivileges = $request->request->all('privileges') ?? [];
                $additionalRoles = [];
                foreach ($selectedPrivileges as $privilege) {
                    if (isset($privilegeRoleMap[$privilege])) {
                        $additionalRoles[] = $privilegeRoleMap[$privilege];
                    }
                }
                // For a limited admin, assign a base role plus extra privilege roles.
                $roles = array_merge(['ROLE_LIMITED_ADMIN'], $additionalRoles);
                $user->setRoles($roles);
                // Optionally store privileges:
                $user->setPrivileges($selectedPrivileges);
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
    public function edit(Request $request, User $user): Response
    {
        if ($request->isMethod('POST')) {
            $email = $request->request->get('email');
            $rolesInput = $request->request->get('roles', '');
            $roles = array_map('trim', explode(',', $rolesInput));

            if (empty($email)) {
                $this->addFlash('error', 'Email is required.');
                return $this->render('admin/user/edit.html.twig', [
                    'user' => $user
                ]);
            }

            $user->setEmail($email);
            $user->setRoles($roles);
            // Update additional properties as needed

            $this->entityManager->flush();
            $this->addFlash('success', 'User updated successfully.');
            return $this->redirectToRoute('admin_users_index');
        }

        return $this->render('admin/user/edit.html.twig', [
            'user' => $user,
        ]);
    }

    #[Route('/{id}/delete', name: 'admin_user_delete', methods: ['POST'])]
    public function delete(Request $request, User $user): Response
    {
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
