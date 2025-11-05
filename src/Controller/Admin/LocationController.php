<?php

namespace App\Controller\Admin;

use App\Entity\Location;
use App\Repository\LocationRepository;
use App\Repository\ExemplaireRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Sensio\Bundle\FrameworkExtraBundle\Configuration\Security;

#[Route('/admin/locations')]
#[Security("is_granted('ROLE_ADMIN')")]
class LocationController extends AbstractController
{
    public function __construct(
        private LocationRepository $locationRepository,
        private ExemplaireRepository $exemplaireRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_locations_index', methods: ['GET'])]
    public function index(Request $request): Response
    {
        $search = trim($request->query->get('search', ''));
        
        if ($search) {
            $locations = $this->locationRepository->createQueryBuilder('l')
                ->where('l.name LIKE :search')
                ->setParameter('search', '%' . $search . '%')
                ->orderBy('l.name', 'ASC')
                ->getQuery()
                ->getResult();
        } else {
            $locations = $this->locationRepository->findBy([], ['name' => 'ASC']);
        }

        // Count exemplaires for each location
        $locationsWithCount = [];
        foreach ($locations as $location) {
            $count = $this->exemplaireRepository->count(['location' => $location]);
            $locationsWithCount[] = [
                'location' => $location,
                'exemplairesCount' => $count
            ];
        }

        return $this->render('admin/location/index.html.twig', [
            'locations' => $locationsWithCount,
            'search' => $search,
        ]);
    }

    #[Route('/new', name: 'admin_location_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $name = trim($request->request->get('name', ''));

            if (empty($name)) {
                $this->addFlash('error', 'Le nom de l\'emplacement est requis.');
                return $this->redirectToRoute('admin_locations_index');
            }

            // Check if location already exists
            $existing = $this->locationRepository->findOneBy(['name' => $name]);
            if ($existing) {
                $this->addFlash('error', 'Un emplacement avec ce nom existe déjà.');
                return $this->redirectToRoute('admin_locations_index');
            }

            $location = new Location();
            $location->setName($name);

            $this->entityManager->persist($location);
            $this->entityManager->flush();

            $this->addFlash('success', 'Emplacement créé avec succès.');
            return $this->redirectToRoute('admin_locations_index');
        }

        return $this->render('admin/location/new.html.twig');
    }

    #[Route('/{id}/edit', name: 'admin_location_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Location $location): Response
    {
        if ($request->isMethod('POST')) {
            $name = trim($request->request->get('name', ''));

            if (empty($name)) {
                $this->addFlash('error', 'Le nom de l\'emplacement est requis.');
                return $this->redirectToRoute('admin_location_edit', ['id' => $location->getId()]);
            }

            // Check if another location has this name
            $existing = $this->locationRepository->createQueryBuilder('l')
                ->where('l.name = :name')
                ->andWhere('l.id != :id')
                ->setParameter('name', $name)
                ->setParameter('id', $location->getId())
                ->getQuery()
                ->getOneOrNullResult();

            if ($existing) {
                $this->addFlash('error', 'Un autre emplacement avec ce nom existe déjà.');
                return $this->redirectToRoute('admin_location_edit', ['id' => $location->getId()]);
            }

            $location->setName($name);
            $this->entityManager->flush();

            $this->addFlash('success', 'Emplacement modifié avec succès.');
            return $this->redirectToRoute('admin_locations_index');
        }

        return $this->render('admin/location/edit.html.twig', [
            'location' => $location,
        ]);
    }

    #[Route('/{id}/delete', name: 'admin_location_delete', methods: ['POST'])]
    public function delete(Request $request, Location $location): Response
    {
        if ($this->isCsrfTokenValid('delete'.$location->getId(), $request->request->get('_token'))) {
            // Check if location has exemplaires
            $exemplairesCount = $this->exemplaireRepository->count(['location' => $location]);
            
            if ($exemplairesCount > 0) {
                $this->addFlash('error', "Impossible de supprimer cet emplacement car $exemplairesCount exemplaire(s) y sont associés.");
                return $this->redirectToRoute('admin_locations_index');
            }

            $this->entityManager->remove($location);
            $this->entityManager->flush();

            $this->addFlash('success', 'Emplacement supprimé avec succès.');
        }

        return $this->redirectToRoute('admin_locations_index');
    }

    #[Route('/quick-create', name: 'admin_location_quick_create', methods: ['POST'])]
    public function quickCreate(Request $request): JsonResponse
    {
        $name = trim($request->request->get('name', ''));

        if (empty($name)) {
            return new JsonResponse([
                'success' => false,
                'error' => 'Le nom de l\'emplacement est requis.'
            ], 400);
        }

        // Check if location already exists
        $existing = $this->locationRepository->findOneBy(['name' => $name]);
        if ($existing) {
            return new JsonResponse([
                'success' => false,
                'error' => 'Un emplacement avec ce nom existe déjà.'
            ], 400);
        }

        $location = new Location();
        $location->setName($name);

        $this->entityManager->persist($location);
        $this->entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'id' => $location->getId(),
            'name' => $location->getName()
        ]);
    }
}
