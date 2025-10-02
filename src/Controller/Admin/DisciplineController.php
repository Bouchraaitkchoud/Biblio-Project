<?php

namespace App\Controller\Admin;

use App\Entity\Discipline;
use App\Repository\DisciplineRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\Routing\Annotation\Route;

#[Route('/admin/disciplines', name: 'admin_disciplines_')]
class DisciplineController extends AbstractController
{
    #[Route('/', name: 'index', methods: ['GET'])]
    public function index(DisciplineRepository $disciplineRepository): Response
    {
        return $this->render('admin/discipline/index.html.twig', [
            'disciplines' => $disciplineRepository->findAll(),
        ]);
    }

    #[Route('/quick-create', name: 'quick_create', methods: ['POST'])]
    public function quickCreate(Request $request, EntityManagerInterface $entityManager): Response
    {
        $data = json_decode($request->getContent(), true);
        $disciplineName = $data['name'] ?? null;

        if (empty($disciplineName)) {
            return $this->json(['error' => 'Discipline name is required'], Response::HTTP_BAD_REQUEST);
        }

        $discipline = new Discipline();
        $discipline->setName($disciplineName);

        $entityManager->persist($discipline);
        $entityManager->flush();

        return $this->json([
            'id' => $discipline->getId(),
            'name' => $discipline->getName()
        ], Response::HTTP_CREATED);
    }
}
