<?php

namespace App\Controller\Admin;

use App\Entity\Publisher;
use App\Repository\PublisherRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/publishers')]
#[IsGranted('ROLE_ADMIN')]
class PublisherController extends AbstractController
{
    public function __construct(
        private PublisherRepository $publisherRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_publishers_index')]
    public function index(Request $request): Response
    {
        $searchTerm = $request->query->get('search');
        $page = max(1, $request->query->getInt('page', 1));
        $limit = 20;
        
        $paginationData = $this->publisherRepository->getPaginatedPublishers($page, $limit, $searchTerm);
        
        return $this->render('admin/publisher/index.html.twig', [
            'publishers' => $paginationData['publishers'],
            'pagination' => [
                'currentPage' => $paginationData['currentPage'],
                'totalPages' => $paginationData['totalPages'],
                'totalItems' => $paginationData['totalItems'],
            ],
            'searchTerm' => $searchTerm,
        ]);
    }
    
    #[Route('/new', name: 'admin_publisher_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $name = $request->request->get('name');
            $address = $request->request->get('address');
            $city = $request->request->get('city');
            $country = $request->request->get('country');
            $website = $request->request->get('website');
            $comment = $request->request->get('comment');
            
            if (empty($name)) {
                $this->addFlash('error', 'Publisher name cannot be empty.');
                return $this->render('admin/publisher/new.html.twig');
            }
            
            $publisher = new Publisher();
            $publisher->setName($name);
            $publisher->setAddress($address);
            $publisher->setCity($city);
            $publisher->setCountry($country);
            $publisher->setWebsite($website);
            $publisher->setComment($comment);
            
            $this->entityManager->persist($publisher);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Publisher created successfully.');
            
            if ($request->isXmlHttpRequest()) {
                return new JsonResponse([
                    'success' => true,
                    'id' => $publisher->getId(),
                    'name' => $publisher->getName()
                ]);
            }
            
            return $this->redirectToRoute('admin_publishers_index');
        }
        
        return $this->render('admin/publisher/new.html.twig');
    }
    
    #[Route('/{id}', name: 'admin_publisher_show', methods: ['GET'])]
    public function show(Publisher $publisher): Response
    {
        return $this->render('admin/publisher/show.html.twig', [
            'publisher' => $publisher,
        ]);
    }
    
    #[Route('/{id}/edit', name: 'admin_publisher_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Publisher $publisher): Response
    {
        $form = $this->createForm(\App\Form\PublisherType::class, $publisher);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->entityManager->flush();
            $this->addFlash('success', 'Publisher updated successfully.');
            return $this->redirectToRoute('admin_publishers_index');
        }

        return $this->render('admin/publisher/edit.html.twig', [
            'publisher' => $publisher,
            'form' => $form->createView(),
        ]);
    }
    
    #[Route('/{id}/delete', name: 'admin_publisher_delete', methods: ['POST'])]
    public function delete(Request $request, Publisher $publisher): Response
    {
        if ($this->isCsrfTokenValid('delete'.$publisher->getId(), $request->request->get('_token'))) {
            
            // Check if it has books
            if (!$publisher->getBooks()->isEmpty()) {
                $this->addFlash('error', 'Cannot delete publisher that has books.');
                return $this->redirectToRoute('admin_publishers_index');
            }
            
            $this->entityManager->remove($publisher);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Publisher deleted successfully.');
        }
        
        return $this->redirectToRoute('admin_publishers_index');
    }
    
    #[Route('/quick-create', name: 'admin_publisher_quick_create', methods: ['POST'])]
    public function quickCreate(Request $request): JsonResponse
    {
        $name = $request->request->get('name');
        $address = $request->request->get('address', '');
        $city = $request->request->get('city', '');
        $country = $request->request->get('country', '');
        $website = $request->request->get('website', '');
        
        if (empty($name)) {
            return new JsonResponse([
                'success' => false,
                'error' => 'Publisher name is required.'
            ], 400);
        }
        
        $publisher = new Publisher();
        $publisher->setName($name);
        $publisher->setAddress($address);
        $publisher->setCity($city);
        $publisher->setCountry($country);
        $publisher->setWebsite($website);
        
        $this->entityManager->persist($publisher);
        $this->entityManager->flush();
        
        return new JsonResponse([
            'success' => true,
            'id' => $publisher->getId(),
            'name' => $publisher->getName()
        ]);
    }
} 