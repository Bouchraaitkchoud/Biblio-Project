<?php
// src/Entity/Section.php
namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\Repository\SectionRepository;

#[ORM\Entity(repositoryClass: SectionRepository::class)]
class Section
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\ManyToOne(targetEntity: Domain::class, inversedBy: 'sections')]
    #[ORM\JoinColumn(nullable: false)]
    private ?Domain $domain = null;

    #[ORM\OneToMany(mappedBy: 'section', targetEntity: Book::class)]
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

    public function getName(): ?string
    {
        return $this->name;
    }

    public function setName(string $name): self
    {
        $this->name = $name;
        return $this;
    }

    public function getDomain(): ?Domain
    {
        return $this->domain;
    }

    public function setDomain(?Domain $domain): self
    {
        $this->domain = $domain;
        return $this;
    }

    public function getBooks(): Collection
    {
        return $this->books;
    }

    public function addBook(Book $book): self
    {
        if (!$this->books->contains($book)) {
            $this->books[] = $book;
            $book->setSection($this);
        }
        return $this;
    }

    public function removeBook(Book $book): self
    {
        if ($this->books->removeElement($book)) {
            if ($book->getSection() === $this) {
                $book->setSection(null);
            }
        }
        return $this;
    }
}