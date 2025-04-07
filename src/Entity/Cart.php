<?php
// src/Entity/Cart.php
namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Cart
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\OneToOne(targetEntity: User::class, inversedBy: 'cart')]
    #[ORM\JoinColumn(nullable: false)]

    private ?User $student = null;

    #[ORM\ManyToMany(targetEntity: Book::class, inversedBy: 'carts')]
    #[ORM\JoinTable(name: 'cart_book')] // Explicitly define the join table
    private Collection $books;

    public function __construct()
    {
        $this->books = new ArrayCollection();
    }

    // Getters and setters
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getStudent(): ?User
    {
        return $this->student;
    }

    public function setStudent(User $student): self
    {
        $this->student = $student;
        return $this;
    }

    /**
     * @return Collection<int, Book>
     */
    public function getBooks(): Collection
    {
        return $this->books;
    }

    public function addBook(Book $book): self
    {
        if (!$this->books->contains($book)) {
            $this->books[] = $book;
        }
        return $this;
    }

    public function removeBook(Book $book): self
    {
        $this->books->removeElement($book);
        return $this;
    }
}