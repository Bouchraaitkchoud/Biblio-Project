<?php
// src/Controller/CartController.php
namespace App\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\AbstractController;
use Symfony\Component\HttpFoundation\JsonResponse;
use Symfony\Component\Routing\Annotation\Route;
use Symfony\Component\Security\Core\Security;
use App\Entity\Book;
use App\Entity\Cart;
use Doctrine\ORM\EntityManagerInterface;

class CartController extends AbstractController
{
    #[Route('/add-to-cart/{id}', name: 'add_to_cart', methods: ['POST'])]
   
// src/Controller/CartController.php
public function addToCart(int $id, EntityManagerInterface $entityManager, Security $security): JsonResponse
{
    // Fetch the book
    $book = $entityManager->getRepository(Book::class)->find($id);
    if (!$book) {
        return new JsonResponse(['success' => false, 'message' => 'Book not found']);
    }

    // Debug: Check if the book is fetched correctly
    dd('Book fetched:', $book);

    // Get the user
    $student = $security->getUser();
    if (!$student) {
        return new JsonResponse(['success' => false, 'message' => 'User not found']);
    }

    // Debug: Check if the user is fetched correctly
    dd('User fetched:', $student);

    // Get or create the cart
    $cart = $student->getCart();
    if (!$cart) {
        $cart = new Cart();
        $cart->setStudent($student); // Set the student on the cart
        $student->setCart($cart); // Set the cart on the user
        $entityManager->persist($cart); // Persist the cart
    }

    // Debug: Check if the cart is created/updated correctly
    dd('Cart created/updated:', $cart);

    // Add the book to the cart
    $cart->addBook($book);

    // Debug: Check if the book is added to the cart
    if (!$cart->getBooks()->contains($book)) {
        return new JsonResponse(['success' => false, 'message' => 'Failed to add book to cart']);
    }

    // Debug: Inspect the cart object
    dd('Cart after adding book:', $cart);

    // Save changes
    $entityManager->flush(); // Only flush here (no need to persist again)

    // Debug: Check if the flush was successful
    dd('Flush completed');

    return new JsonResponse(['success' => true, 'message' => 'Book added to cart']);
}
}