<?php
// src/Entity/Discipline.php
namespace App\Entity;

use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\Common\Collections\Collection;
use Doctrine\ORM\Mapping as ORM;
use App\Repository\DisciplineRepository;

#[ORM\Entity(repositoryClass: DisciplineRepository::class)]
class Discipline
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\Column(length: 255)]
    private ?string $name = null;

    #[ORM\Column(length: 255, nullable: true)]
    private ?string $image = null;

    #[ORM\OneToMany(mappedBy: 'discipline', targetEntity: Book::class)]
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

    public function getImage(): ?string
    {
        return $this->image;
    }

    public function setImage(?string $image): self
    {
        $this->image = $image;
        return $this;
    }

    /**
     * Get the image URL for this discipline, or a default one based on the name
     */
    public function getImageUrl(): string
    {
        if ($this->image) {
            return '/images/disciplines/' . $this->image;
        }

        // Default images based on discipline name
        $defaultImages = [
            'informatique' => 'informatique.png',
            'mathematiques' => 'mathematiques.png',
            'physique' => 'physique.png',
            'chimie' => 'chimie.png',
            'biologie' => 'biologie.png',
            'histoire' => 'histoire.png',
            'geographie' => 'geographie.png',
            'litterature' => 'litterature.png',
            'philosophie' => 'philosophie.png',
            'economie' => 'economie.png',
            'psychologie' => 'psychologie.png',
            'sociologie' => 'sociologie.png',
            'droit' => 'droit.png',
            'medecine' => 'medecine.png',
            'art' => 'art.png',
            'musique' => 'musique.png',
            'sport' => 'sport.png',
            'langues' => 'langues.png',
        ];

        $disciplineName = strtolower($this->name);
        foreach ($defaultImages as $keyword => $imageName) {
            if (str_contains($disciplineName, $keyword)) {
                return '/images/disciplines/' . $imageName;
            }
        }

        // Default fallback image
        return '/images/disciplines/default.png';
    }

    public function getBooks(): Collection
    {
        return $this->books;
    }

    public function addBook(Book $book): self
    {
        if (!$this->books->contains($book)) {
            $this->books[] = $book;
            $book->setDiscipline($this);
        }
        return $this;
    }

    public function removeBook(Book $book): self
    {
        if ($this->books->removeElement($book)) {
            if ($book->getDiscipline() === $this) {
                $book->setDiscipline(null);
            }
        }
        return $this;
    }
}