<?php
// filepath: c:\Users\Hp\Biblio-Project\biblio-project-backend\src\Controller\Admin\ConfigController.php

namespace App\Controller\Admin;

use App\Entity\SystemConfig;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/config')]
#[IsGranted('ROLE_ADMIN')]
class ConfigController extends AbstractController
{
    public function __construct(
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/system', name: 'admin_config_system', methods: ['GET', 'POST'])]
    public function systemConfig(Request $request): Response
    {
        // Get or create the max books config
        $repo = $this->entityManager->getRepository(SystemConfig::class);
        $maxBooksConfig = $repo->findOneBy(['key' => 'max_books_per_order']);

        if (!$maxBooksConfig) {
            $maxBooksConfig = new SystemConfig();
            $maxBooksConfig->setKey('max_books_per_order');
            $maxBooksConfig->setValue('5');
            $maxBooksConfig->setDescription('Maximum number of books a lecteur can borrow per order');
            $this->entityManager->persist($maxBooksConfig);
            $this->entityManager->flush();
        }

        if ($request->isMethod('POST')) {
            $maxBooks = (int)$request->request->get('max_books');

            // Validation
            if ($maxBooks < 1) {
                $this->addFlash('error', 'Le nombre de livres doit être au moins 1.');
                return $this->redirectToRoute('admin_config_system');
            }

            if ($maxBooks > 100) {
                $this->addFlash('error', 'Le nombre de livres ne peut pas dépasser 100.');
                return $this->redirectToRoute('admin_config_system');
            }

            $maxBooksConfig->setValue((string)$maxBooks);
            $this->entityManager->flush();

            $this->addFlash('success', sprintf('Limite maximale définie à %d livre(s).', $maxBooks));
            return $this->redirectToRoute('admin_config_system');
        }

        return $this->render('admin/config/system.html.twig', [
            'maxBooks' => (int)$maxBooksConfig->getValue(),
        ]);
    }
}