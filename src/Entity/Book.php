<?php

namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\Repository\BookRepository;

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

    #[ORM\ManyToMany(targetEntity: Author::class, inversedBy: 'books')]
    #[ORM\JoinTable(name: 'book_author')]
    private Collection $authors;

    #[ORM\ManyToOne(targetEntity: Section::class, inversedBy: 'books')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Section $section = null;

    #[ORM\Column(type: "blob", nullable: true)]
    private $coverImage = null;

    #[ORM\Column(type: "text", nullable: true)]
    private ?string $description = null;

    #[ORM\Column(type: "integer", nullable: true)]
    private ?int $publicationYear = null;

    #[ORM\Column(type: "string", length: 50, nullable: true)]
    private ?string $isbn = null;

    public function __construct()
    {
        $this->carts = new ArrayCollection();
        $this->authors = new ArrayCollection();
    }

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

    /**
     * @return Collection<int, Author>
     */
    public function getAuthors(): Collection
    {
        return $this->authors;
    }

    public function addAuthor(Author $author): self
    {
        if (!$this->authors->contains($author)) {
            $this->authors->add($author);
        }
        
        return $this;
    }

    public function removeAuthor(Author $author): self
    {
        $this->authors->removeElement($author);
        return $this;
    }
    
    /**
     * For backward compatibility - gets the main author's name
     */
    public function getAuthorName(): ?string
    {
        if ($this->authors->isEmpty()) {
            return null;
        }
        
        $authorNames = [];
        foreach ($this->authors as $author) {
            $authorNames[] = $author->getName();
        }
        
        return implode(', ', $authorNames);
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

    public function getCoverImage()
    {
        if ($this->coverImage === null) {
            return null;
        }
        
        $data = stream_get_contents($this->coverImage);
        
        if ($data) {
            return 'data:image/jpeg;base64,' . base64_encode($data);
        }
        
        return null;
    }

    public function setCoverImage($coverImage): self
    {
        $this->coverImage = $coverImage;
        return $this;
    }
    
    public function getDescription(): ?string
    {
        return $this->description;
    }
    
    public function setDescription(?string $description): self
    {
        $this->description = $description;
        return $this;
    }
    
    public function getPublicationYear(): ?int
    {
        return $this->publicationYear;
    }
    
    public function setPublicationYear(?int $publicationYear): self
    {
        $this->publicationYear = $publicationYear;
        return $this;
    }
    
    public function getIsbn(): ?string
    {
        return $this->isbn;
    }
    
    public function setIsbn(?string $isbn): self
    {
        $this->isbn = $isbn;
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
            if (!$cart->getBooks()->contains($this)) {
                $cart->addBook($this);
            }
        }
        return $this;
    }

    public function removeCart(Cart $cart): self
    {
        if ($this->carts->removeElement($cart)) {
            if ($cart->getBooks()->contains($this)) {
                $cart->removeBook($this);
            }
        }
        return $this;
    }
}
