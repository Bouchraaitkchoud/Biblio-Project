<?php

namespace App\Controller;

use App\Service\DatabaseBackupService;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\BinaryFileResponse;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/maintenance')]
#[IsGranted('ROLE_ADMIN')]
class AdminMaintenanceController extends AbstractController
{
    private DatabaseBackupService $backupService;

    public function __construct(DatabaseBackupService $backupService)
    {
        $this->backupService = $backupService;
    }

    /**
     * Main maintenance page - list backups
     */
    #[Route('', name: 'admin_maintenance')]
    public function index(): Response
    {
        $backups = $this->backupService->listBackups();
        $academicYear = $this->backupService->calculateAcademicYear();

        return $this->render('admin/maintenance/database.html.twig', [
            'backups' => $backups,
            'currentAcademicYear' => $academicYear
        ]);
    }

    /**
     * Create backup and clean student data
     */
    #[Route('/backup-and-clean', name: 'admin_maintenance_backup_clean', methods: ['POST'])]
    public function backupAndClean(): Response
    {
        // Step 1: Create backup
        $backupResult = $this->backupService->createBackup();

        if (!$backupResult['success']) {
            $this->addFlash('error', 'Erreur lors de la création de la sauvegarde: ' . $backupResult['error']);
            return $this->redirectToRoute('admin_maintenance');
        }

        // Step 2: Clean student data
        $cleanResult = $this->backupService->cleanStudentData();

        if (!$cleanResult['success']) {
            $this->addFlash('error', 'La sauvegarde a été créée, mais erreur lors du nettoyage des données: ' . $cleanResult['error']);
            return $this->redirectToRoute('admin_maintenance');
        }

        // Success message with details
        $message = sprintf(
            'Sauvegarde créée avec succès (%s) et données nettoyées: %d lecteurs, %d commandes, %d items de commande, %d paniers, %d items de panier, %d reçus supprimés.',
            $backupResult['filename'],
            $cleanResult['deleted']['lecteurs'],
            $cleanResult['deleted']['orders'],
            $cleanResult['deleted']['orderItems'],
            $cleanResult['deleted']['carts'],
            $cleanResult['deleted']['cartItems'],
            $cleanResult['deleted']['receipts']
        );

        $this->addFlash('success', $message);
        return $this->redirectToRoute('admin_maintenance');
    }

    /**
     * Download backup file
     */
    #[Route('/download/{filename}', name: 'admin_maintenance_download')]
    public function download(string $filename): Response
    {
        $backupPath = $this->backupService->getBackupPath($filename);

        if (!$backupPath) {
            $this->addFlash('error', 'Fichier de sauvegarde introuvable.');
            return $this->redirectToRoute('admin_maintenance');
        }

        $response = new BinaryFileResponse($backupPath);
        
        // Manually set MIME type to avoid fileinfo dependency
        $response->headers->set('Content-Type', 'application/sql');
        
        $response->setContentDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            $filename
        );

        return $response;
    }

    /**
     * Delete backup file
     */
    #[Route('/delete/{filename}', name: 'admin_maintenance_delete', methods: ['POST'])]
    public function delete(string $filename): Response
    {
        $result = $this->backupService->deleteBackup($filename);

        if ($result) {
            $this->addFlash('success', 'Sauvegarde supprimée avec succès.');
        } else {
            $this->addFlash('error', 'Erreur lors de la suppression de la sauvegarde.');
        }

        return $this->redirectToRoute('admin_maintenance');
    }
}
