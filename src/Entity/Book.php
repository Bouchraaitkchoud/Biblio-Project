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

    #[ORM\Column(length: 255)]
    private ?string $title = null;

    #[ORM\ManyToMany(targetEntity: Author::class, inversedBy: 'books')]
    #[ORM\JoinTable(name: 'book_author')]
    private Collection $authors;

    #[ORM\ManyToMany(targetEntity: Discipline::class, inversedBy: 'books')]
    #[ORM\JoinTable(name: 'book_discipline')]
    private Collection $disciplines;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $coverImage = null;

    #[ORM\Column(type: "text", nullable: true)]
    private ?string $description = null;

    #[ORM\Column(type: "integer", nullable: true)]
    private ?int $publicationYear = null;

    #[ORM\Column(type: "string", length: 50, nullable: true)]
    private ?string $isbn = null;
    
    #[ORM\ManyToMany(targetEntity: Publisher::class, inversedBy: 'books')]
    #[ORM\JoinTable(name: 'book_publisher')]
    private Collection $publishers;

    #[ORM\OneToMany(mappedBy: 'book', targetEntity: Exemplaire::class, orphanRemoval: true)]
    private Collection $exemplaires;

    #[ORM\Column(name: 'document_type', length: 50, nullable: true)]
    private ?string $documentType = null;

    public function __construct()
    {
        $this->authors = new ArrayCollection();
        $this->publishers = new ArrayCollection();
        $this->exemplaires = new ArrayCollection();
        $this->disciplines = new ArrayCollection();
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

    /**
     * @return Collection<int, Discipline>
     */
    public function getDisciplines(): Collection
    {
        return $this->disciplines;
    }

    public function addDiscipline(Discipline $discipline): self
    {
        if (!$this->disciplines->contains($discipline)) {
            $this->disciplines->add($discipline);
        }
        
        return $this;
    }

    public function removeDiscipline(Discipline $discipline): self
    {
        $this->disciplines->removeElement($discipline);
        return $this;
    }

    public function getCoverImage(): ?string
    {
        return $this->coverImage;
    }

    public function getCoverImageUrl(): string
    {
        if ($this->coverImage) {
            return '/uploads/book_covers/' . $this->coverImage;
        }

        // Default book cover
        return '/images/book-placeholder.jpg';
    }

    public function setCoverImage(?string $coverImage): self
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

    /**
     * @return Collection<int, Publisher>
     */
    public function getPublishers(): Collection
    {
        return $this->publishers;
    }
    
    public function addPublisher(Publisher $publisher): self
    {
        if (!$this->publishers->contains($publisher)) {
            $this->publishers->add($publisher);
        }
        
        return $this;
    }
    
    public function removePublisher(Publisher $publisher): self
    {
        $this->publishers->removeElement($publisher);
        return $this;
    }
    
    /**
     * For convenience - gets the main publisher's name
     */
    public function getPublisherName(): ?string
    {
        if ($this->publishers->isEmpty()) {
            return null;
        }
        
        $publisherNames = [];
        foreach ($this->publishers as $publisher) {
            $publisherNames[] = $publisher->getName();
        }
        
        return implode(', ', $publisherNames);
    }

    /**
     * @return Collection<int, Exemplaire>
     */
    public function getExemplaires(): Collection
    {
        return $this->exemplaires;
    }

    public function addExemplaire(Exemplaire $exemplaire): self
    {
        if (!$this->exemplaires->contains($exemplaire)) {
            $this->exemplaires->add($exemplaire);
            $exemplaire->setBook($this);
        }
        return $this;
    }

    public function removeExemplaire(Exemplaire $exemplaire): self
    {
        if ($this->exemplaires->removeElement($exemplaire)) {
            if ($exemplaire->getBook() === $this) {
                $exemplaire->setBook(null);
            }
        }
        return $this;
    }

    /**
     * Get the number of available copies (exemplaires with status = 'available')
     */
    public function getAvailableCopies(): int
    {
        return $this->exemplaires->filter(function(Exemplaire $exemplaire) {
            return $exemplaire->getStatus() === 'available';
        })->count();
    }

    public function getDocumentType(): ?string
    {
        return $this->documentType;
    }

    public function setDocumentType(?string $documentType): self
    {
        $this->documentType = $documentType;
        return $this;
    }

    /**
     * Get available exemplaires (not borrowed or damaged)
     */
    public function getAvailableExemplaires(): Collection
    {
        return $this->exemplaires->filter(function(Exemplaire $exemplaire) {
            return $exemplaire->getStatus() === 'available';
        });
    }

    /**
     * Check if book has available exemplaires
     */
    public function isAvailable(): bool
    {
        return $this->getAvailableExemplaires()->count() > 0;
    }

    /**
     * Get count of available exemplaires
     */
    public function getAvailableCount(): int
    {
        return $this->getAvailableExemplaires()->count();
    }
}
