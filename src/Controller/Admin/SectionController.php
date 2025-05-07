<?php

namespace App\Controller\Admin;

use App\Entity\Domain;
use App\Entity\Section;
use App\Repository\DomainRepository;
use App\Repository\SectionRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;
use Symfony\Component\Form\Extension\Core\Type\FormType;
use Symfony\Component\Form\Extension\Core\Type\SubmitType;

#[Route('/admin/sections')]
#[IsGranted('ROLE_ADMIN')]
class SectionController extends AbstractController
{
    public function __construct(
        private SectionRepository $sectionRepository,
        private DomainRepository $domainRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_sections_index')]
    public function index(Request $request): Response
    {
        $searchTerm = $request->query->get('search');
        $page = max(1, $request->query->getInt('page', 1));
        $limit = 20;
        
        $paginationData = $this->sectionRepository->getPaginatedSections($page, $limit, $searchTerm);
        
        return $this->render('admin/section/index.html.twig', [
            'sections' => $paginationData['sections'],
            'pagination' => [
                'currentPage' => $paginationData['currentPage'],
                'totalPages' => $paginationData['totalPages'],
                'totalItems' => $paginationData['totalItems'],
            ],
            'searchTerm' => $searchTerm,
        ]);
    }
    
    #[Route('/new', name: 'admin_section_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        $domains = $this->domainRepository->findAll();
        
        if ($request->isMethod('POST')) {
            $name = $request->request->get('name');
            $domainId = $request->request->get('domain');
            
            if (empty($name)) {
                $this->addFlash('error', 'Section name cannot be empty.');
                return $this->render('admin/section/new.html.twig', [
                    'domains' => $domains,
                ]);
            }
            
            if (empty($domainId)) {
                $this->addFlash('error', 'Please select a domain.');
                return $this->render('admin/section/new.html.twig', [
                    'domains' => $domains,
                ]);
            }
            
            $domain = $this->domainRepository->find($domainId);
            if (!$domain) {
                $this->addFlash('error', 'Selected domain does not exist.');
                return $this->render('admin/section/new.html.twig', [
                    'domains' => $domains,
                ]);
            }
            
            $section = new Section();
            $section->setName($name);
            $section->setDomain($domain);
            
            $this->entityManager->persist($section);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Section created successfully.');
            return $this->redirectToRoute('admin_sections_index');
        }
        
        return $this->render('admin/section/new.html.twig', [
            'domains' => $domains,
        ]);
    }
    
    #[Route('/{id}', name: 'admin_section_show', methods: ['GET'])]
    public function show(Section $section): Response
    {
        return $this->render('admin/section/show.html.twig', [
            'section' => $section,
        ]);
    }
    
    #[Route('/{id}/edit', name: 'admin_section_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Section $section): Response
    {
        $form = $this->createForm(\App\Form\SectionType::class, $section);
        $form->handleRequest($request);

        if ($form->isSubmitted() && $form->isValid()) {
            $this->entityManager->flush();
            $this->addFlash('success', 'Section updated successfully.');
            return $this->redirectToRoute('admin_sections_index');
        }

        return $this->render('admin/section/edit.html.twig', [
            'section' => $section,
            'form' => $form->createView(),
        ]);
    }
    
    #[Route('/{id}/delete', name: 'admin_section_delete', methods: ['POST'])]
    public function delete(Request $request, Section $section): Response
    {
        if ($this->isCsrfTokenValid('delete'.$section->getId(), $request->request->get('_token'))) {
            
            // Check if it has books
            if (!$section->getBooks()->isEmpty()) {
                $this->addFlash('error', 'Cannot delete section that has books.');
                return $this->redirectToRoute('admin_sections_index');
            }
            
            $this->entityManager->remove($section);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Section deleted successfully.');
        }
        
        return $this->redirectToRoute('admin_sections_index');
    }
    
    #[Route('/quick-create', name: 'admin_section_quick_create', methods: ['POST'])]
    public function quickCreate(Request $request): JsonResponse
    {
        $name = $request->request->get('name');
        $domainId = $request->request->get('domain');
        
        if (empty($name) || empty($domainId)) {
            return new JsonResponse([
                'success' => false,
                'error' => 'Section name and domain are required.'
            ], 400);
        }
        
        $domain = $this->domainRepository->find($domainId);
        if (!$domain) {
            return new JsonResponse([
                'success' => false,
                'error' => 'Selected domain does not exist.'
            ], 400);
        }
        
        $section = new Section();
        $section->setName($name);
        $section->setDomain($domain);
        
        $this->entityManager->persist($section);
        $this->entityManager->flush();
        
        return new JsonResponse([
            'success' => true,
            'id' => $section->getId(),
            'name' => $section->getName(),
            'domainId' => $domain->getId(),
            'domainName' => $domain->getName()
        ]);
    }
} 