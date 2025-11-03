<?php

namespace App\Controller\Admin;

use App\Entity\Lecteur;
use App\Form\LecteurType;
use App\Repository\LecteurRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\ResponseHeaderBag;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

#[Route('/admin/lecteurs')]
#[Security("is_granted('ROLE_ADMIN') or is_granted('ROLE_GERER_LECTEURS')")]
class LecteurController extends AbstractController
{
    public function __construct(private EntityManagerInterface $entityManager) {}

    #[Route('/', name: 'admin_lecteurs_index', methods: ['GET'])]
    public function index(LecteurRepository $lecteurRepository): Response
    {
        $lecteurs = $lecteurRepository->findAll();
        return $this->render('admin/lecteur/index.html.twig', [
            'lecteurs' => $lecteurs,
        ]);
    }
    
    #[Route('/export-csv', name: 'admin_lecteurs_export_csv', methods: ['GET'])]
    public function exportCsv(LecteurRepository $lecteurRepository): Response
    {
        $lecteurs = $lecteurRepository->findAll();

        // Build CSV header and content, including the "Mot de passe" column
        $csvData = "Nom,Prénom,Code d'admission,Établissement,Formation,Promotion,Email,Mot de passe\n";
        foreach ($lecteurs as $lecteur) {
            $nom = str_replace([",", "\n"], [" ", " "], $lecteur->getNom());
            $prenom = str_replace([",", "\n"], [" ", " "], $lecteur->getPrenom());
            $codeAdmission = str_replace([",", "\n"], [" ", " "], $lecteur->getCodeAdmission());
            $etablissement = str_replace([",", "\n"], [" ", " "], $lecteur->getEtablissement());
            $formation = str_replace([",", "\n"], [" ", " "], $lecteur->getFormation());
            $promotion = str_replace([",", "\n"], [" ", " "], $lecteur->getPromotion());
            $email = str_replace([",", "\n"], [" ", " "], $lecteur->getEmail());
            $motDePasse = str_replace([",", "\n"], [" ", " "], $lecteur->getPassword());
            
            // Surround fields with quotes to properly handle commas in data
            $csvData .= sprintf('"%s","%s","%s","%s","%s","%s","%s","%s"' . "\n",
                $nom,
                $prenom,
                $codeAdmission,
                $etablissement,
                $formation,
                $promotion,
                $email,
                $motDePasse
            );
        }

        $response = new Response($csvData);
        $disposition = $response->headers->makeDisposition(
            ResponseHeaderBag::DISPOSITION_ATTACHMENT,
            'lecteurs.csv'
        );
        $response->headers->set('Content-Disposition', $disposition);
        $response->headers->set('Content-Type', 'text/csv');

        return $response;
    }

    #[Route('/new', name: 'admin_lecteurs_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        $lecteur = new Lecteur();
        $form = $this->createForm(LecteurType::class, $lecteur);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->entityManager->persist($lecteur);
            $this->entityManager->flush();

            $this->addFlash('success', 'Le lecteur a été créé avec succès.');
            return $this->redirectToRoute('admin_lecteurs_index');
        }

        return $this->render('admin/lecteur/new.html.twig', [
            'lecteur' => $lecteur,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/import-csv', name: 'admin_lecteurs_import_csv', methods: ['POST'])]
    public function importCsv(Request $request): Response
    {
        // Verify CSRF token
        if (!$this->isCsrfTokenValid('csv_import', $request->request->get('_token'))) {
            $this->addFlash('error', 'Jeton CSRF invalide.');
            return $this->redirectToRoute('admin_lecteurs_new');
        }

        $csvFile = $request->files->get('csv_file');
        
        if (!$csvFile) {
            $this->addFlash('error', 'Aucun fichier n\'a été uploadé.');
            return $this->redirectToRoute('admin_lecteurs_new');
        }

        if ($csvFile->getClientOriginalExtension() !== 'csv') {
            $this->addFlash('error', 'Le fichier doit être au format CSV.');
            return $this->redirectToRoute('admin_lecteurs_new');
        }

        try {
            $handle = fopen($csvFile->getPathname(), 'r');
            if ($handle === false) {
                throw new \Exception('Impossible d\'ouvrir le fichier CSV.');
            }

            $importedCount = 0;
            $errorCount = 0;
            $lineNumber = 0;
            $errors = [];

            // Skip header row
            $header = fgetcsv($handle);
            $lineNumber++;

            while (($data = fgetcsv($handle)) !== false) {
                $lineNumber++;
                
                // Validate row has all required fields
                if (count($data) < 8) {
                    $errorCount++;
                    $errors[] = "Ligne $lineNumber: Nombre de colonnes insuffisant.";
                    continue;
                }

                try {
                    $lecteur = new Lecteur();
                    $lecteur->setNom(trim($data[0]));
                    $lecteur->setPrenom(trim($data[1]));
                    $lecteur->setCodeAdmission(trim($data[2]));
                    $lecteur->setEtablissement(trim($data[3]));
                    $lecteur->setFormation(trim($data[4]));
                    $lecteur->setPromotion(trim($data[5]));
                    $lecteur->setEmail(trim($data[6]));
                    $lecteur->setPassword(trim($data[7])); // Note: Should hash password in production

                    $this->entityManager->persist($lecteur);
                    $importedCount++;
                } catch (\Exception $e) {
                    $errorCount++;
                    $errors[] = "Ligne $lineNumber: " . $e->getMessage();
                }
            }

            fclose($handle);

            // Flush all persisted entities
            if ($importedCount > 0) {
                $this->entityManager->flush();
            }

            // Display results
            if ($importedCount > 0) {
                $this->addFlash('success', "$importedCount lecteur(s) importé(s) avec succès.");
            }
            
            if ($errorCount > 0) {
                $errorMessage = "$errorCount erreur(s) détectée(s).";
                if (count($errors) > 0) {
                    $errorMessage .= " Détails: " . implode('; ', array_slice($errors, 0, 5));
                    if (count($errors) > 5) {
                        $errorMessage .= "... et " . (count($errors) - 5) . " autre(s) erreur(s).";
                    }
                }
                $this->addFlash('error', $errorMessage);
            }

        } catch (\Exception $e) {
            $this->addFlash('error', 'Erreur lors de l\'import: ' . $e->getMessage());
        }

        return $this->redirectToRoute('admin_lecteurs_new');
    }

    #[Route('/{id}', name: 'admin_lecteurs_show', methods: ['GET'])]
    public function show(Lecteur $lecteur): Response
    {
        return $this->render('admin/lecteur/show.html.twig', [
            'lecteur' => $lecteur,
        ]);
    }

    #[Route('/{id}/edit', name: 'admin_lecteurs_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Lecteur $lecteur): Response
    {
        $form = $this->createForm(LecteurType::class, $lecteur);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->entityManager->flush();
            $this->addFlash('success', 'Le lecteur a été mis à jour avec succès.');
            return $this->redirectToRoute('admin_lecteurs_index');
        }

        return $this->render('admin/lecteur/edit.html.twig', [
            'lecteur' => $lecteur,
            'form' => $form->createView(),
        ]);
    }

    #[Route('/{id}/delete', name: 'admin_lecteurs_delete', methods: ['POST'])]
    public function delete(Request $request, Lecteur $lecteur): Response
    {
        if ($this->isCsrfTokenValid('delete' . $lecteur->getId(), $request->request->get('_token'))) {
            $this->entityManager->remove($lecteur);
            $this->entityManager->flush();
            $this->addFlash('success', 'Le lecteur a été supprimé avec succès.');
        }
        return $this->redirectToRoute('admin_lecteurs_index');
    }
}