<?php

namespace App\Controller\Admin;

use App\Entity\Domain;
use App\Repository\DomainRepository;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\Request;
use Symfony\Component\HttpFoundation\Response;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Http\Attribute\IsGranted;

#[Route('/admin/domains')]
#[IsGranted('ROLE_ADMIN')]
class DomainController extends AbstractController
{
    public function __construct(
        private DomainRepository $domainRepository,
        private EntityManagerInterface $entityManager
    ) {}

    #[Route('/', name: 'admin_domains_index')]
    public function index(Request $request): Response
    {
        $searchTerm = $request->query->get('search');
        $page = max(1, $request->query->getInt('page', 1));
        $limit = 20;
        
        $paginationData = $this->domainRepository->getPaginatedDomains($page, $limit, $searchTerm);
        
        return $this->render('admin/domain/index.html.twig', [
            'domains' => $paginationData['domains'],
            'pagination' => [
                'currentPage' => $paginationData['currentPage'],
                'totalPages' => $paginationData['totalPages'],
                'totalItems' => $paginationData['totalItems'],
            ],
            'searchTerm' => $searchTerm,
        ]);
    }
    
    #[Route('/new', name: 'admin_domain_new', methods: ['GET', 'POST'])]
    public function new(Request $request): Response
    {
        if ($request->isMethod('POST')) {
            $name = $request->request->get('name');
            
            if (!empty($name)) {
                $domain = new Domain();
                $domain->setName($name);
                
                $this->entityManager->persist($domain);
                $this->entityManager->flush();
                
                $this->addFlash('success', 'Domain created successfully.');
                
                // If it's an AJAX request, return JSON response
                if ($request->isXmlHttpRequest()) {
                    return new JsonResponse([
                        'success' => true,
                        'id' => $domain->getId(),
                        'name' => $domain->getName()
                    ]);
                }
                
                return $this->redirectToRoute('admin_domains_index');
            } else {
                $this->addFlash('error', 'Domain name cannot be empty.');
                
                if ($request->isXmlHttpRequest()) {
                    return new JsonResponse([
                        'success' => false,
                        'error' => 'Domain name cannot be empty.'
                    ], 400);
                }
            }
        }
        
        return $this->render('admin/domain/new.html.twig');
    }
    
    #[Route('/{id}', name: 'admin_domain_show', methods: ['GET'])]
    public function show(Domain $domain): Response
    {
        return $this->render('admin/domain/show.html.twig', [
            'domain' => $domain,
        ]);
    }
    
    #[Route('/{id}/edit', name: 'admin_domain_edit', methods: ['GET', 'POST'])]
    public function edit(Request $request, Domain $domain): Response
    {
        if ($request->isMethod('POST')) {
            $name = $request->request->get('name');
            
            if (!empty($name)) {
                $domain->setName($name);
                $this->entityManager->flush();
                
                $this->addFlash('success', 'Domain updated successfully.');
                return $this->redirectToRoute('admin_domains_index');
            } else {
                $this->addFlash('error', 'Domain name cannot be empty.');
            }
        }
        
        return $this->render('admin/domain/edit.html.twig', [
            'domain' => $domain,
        ]);
    }
    
    #[Route('/{id}/delete', name: 'admin_domain_delete', methods: ['POST'])]
    public function delete(Request $request, Domain $domain): Response
    {
        if ($this->isCsrfTokenValid('delete'.$domain->getId(), $request->request->get('_token'))) {
            
            // Check if it has sections
            if (!$domain->getSections()->isEmpty()) {
                $this->addFlash('error', 'Cannot delete domain that has sections.');
                return $this->redirectToRoute('admin_domains_index');
            }
            
            $this->entityManager->remove($domain);
            $this->entityManager->flush();
            
            $this->addFlash('success', 'Domain deleted successfully.');
        }
        
        return $this->redirectToRoute('admin_domains_index');
    }
} 