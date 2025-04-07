<?php

// src/Entity/BorrowingRequest.php
namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class BorrowingRequest
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: User::class)]
    #[ORM\JoinColumn(nullable: false)]
    private ?User $student = null;

    #[ORM\ManyToMany(targetEntity: Book::class)]
    private Collection $books;

    #[ORM\Column(length: 255)]
    private ?string $status = 'pending'; // e.g., pending, validated

    #[ORM\OneToOne(targetEntity: Receipt::class, mappedBy: 'borrowingRequest', cascade: ['persist', 'remove'])]
    private ?Receipt $receipt = null;

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

    public function setStudent(?User $student): self
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

    public function getStatus(): ?string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;
        return $this;
    }

    public function getReceipt(): ?Receipt
    {
        return $this->receipt;
    }

    public function setReceipt(Receipt $receipt): self
    {
        // Set the owning side of the relation
        if ($receipt->getBorrowingRequest() !== $this) {
            $receipt->setBorrowingRequest($this);
        }

        $this->receipt = $receipt;
        return $this;
    }
}