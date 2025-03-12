<?php

namespace App\Controller;

use App\Entity\BorrowingRequest;
use App\Entity\Receipt;
use App\Service\ReceiptCodeGenerator;
use Doctrine\ORM\EntityManagerInterface;
use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Security;

class BorrowingController extends AbstractController
{
    #[Route('/validate-borrowing', name: 'validate_borrowing', methods: ['POST'])]
    public function validateBorrowing(EntityManagerInterface $entityManager, Security $security, ReceiptCodeGenerator $codeGenerator): JsonResponse
    {
        // Get the current user (student)
        $student = $security->getUser();

        // Get the student's cart
        $cart = $student->getCart();

        if (!$cart || $cart->getBooks()->isEmpty()) {
            return new JsonResponse(['success' => false, 'message' => 'Your cart is empty']);
        }

        // Create a new borrowing request
        $borrowingRequest = new BorrowingRequest();
        $borrowingRequest->setStudent($student);
        $borrowingRequest->setStatus('pending');

        // Add books from the cart to the borrowing request
        foreach ($cart->getBooks() as $book) {
            $borrowingRequest->addBook($book);
        }

        // Create a receipt
        $receipt = new Receipt();
        $receipt->setBorrowingRequest($borrowingRequest);
        $receipt->setCode($codeGenerator->generateCode());

        // Save the borrowing request and receipt
        $entityManager->persist($borrowingRequest);
        $entityManager->persist($receipt);
        $entityManager->flush();

        // Clear the student's cart
        $cart->getBooks()->clear();
        $entityManager->flush();

        return new JsonResponse([
            'success' => true,
            'message' => 'Borrowing request validated successfully',
            'receiptCode' => $receipt->getCode(),
        ]);
    }
}