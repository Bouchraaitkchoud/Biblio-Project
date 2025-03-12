<?php
// src/Entity/Book.php
namespace App\Entity;
use Doctrine\Common\Collections\Collection;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity(repositoryClass: BookRepository::class)]
class Book
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;


    #[ORM\ManyToMany(targetEntity: Cart::class, mappedBy: 'books')]
    private Collection $carts;

    #[ORM\Column(length: 255)]
    private ?string $title = null;

    #[ORM\Column(length: 255)]
    private ?string $author = null;

    #[ORM\ManyToOne(targetEntity: Section::class, inversedBy: 'books')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Section $section = null;

    // Getters and setters
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getTitle(): ?string
    {
        return $this->title;
    }

    public function setTitle(string $title): self
    {
        $this->title = $title;
        return $this;
    }

    public function getAuthor(): ?string
    {
        return $this->author;
    }

    public function setAuthor(string $author): self
    {
        $this->author = $author;
        return $this;
    }

    public function getSection(): ?Section
    {
        return $this->section;
    }

    public function setSection(?Section $section): self
    {
        $this->section = $section;
        return $this;
    }
    public function getCarts(): Collection
    {
        return $this->carts;
    }
    
    public function addCart(Cart $cart): self
    {
        if (!$this->carts->contains($cart)) {
            $this->carts[] = $cart;
            $cart->addBook($this);
        }
        return $this;
    }
    
    public function removeCart(Cart $cart): self
    {
        if ($this->carts->removeElement($cart)) {
            $cart->removeBook($this);
        }
        return $this;
    }
}