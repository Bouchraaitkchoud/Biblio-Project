<?php

namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Repository\ExemplaireRepository;

#[ORM\Entity(repositoryClass: ExemplaireRepository::class)]
class Exemplaire
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: Book::class, inversedBy: 'exemplaires')]
    #[ORM\JoinColumn(name: 'book_id', referencedColumnName: 'id', nullable: false)]
    private ?Book $book = null;

    #[ORM\Column(type: 'string', length: 50, unique: true, nullable: false)]
    private ?string $barcode = null;

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $section_id = null;

    #[ORM\Column(type: 'string', length: 20, nullable: false)]
    private string $status = 'available';

    #[ORM\Column(type: 'integer', nullable: true)]
    private ?int $location_id = null;

    #[ORM\Column(type: 'string', length: 50, nullable: true)]
    private ?string $call_number = null;

    #[ORM\Column(type: 'date', nullable: true)]
    private ?\DateTimeInterface $acquisition_date = null;

    #[ORM\Column(type: 'date', nullable: true)]
    private ?\DateTimeInterface $returnDate = null;

    #[ORM\Column(type: 'decimal', precision: 10, scale: 2, nullable: true)]
    private ?string $price = null;

    #[ORM\Column(type: 'string', length: 255, nullable: true)]
    private ?string $comment = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getBook(): ?Book
    {
        return $this->book;
    }

    public function setBook(?Book $book): self
    {
        $this->book = $book;
        return $this;
    }

    public function getBarcode(): ?string
    {
        return $this->barcode;
    }

    public function setBarcode(string $barcode): self
    {
        $this->barcode = $barcode;
        return $this;
    }

    public function getSectionId(): ?int
    {
        return $this->section_id;
    }

    public function setSectionId(?int $section_id): self
    {
        $this->section_id = $section_id;
        return $this;
    }

    public function getStatus(): string
    {
        return $this->status;
    }

    public function setStatus(string $status): self
    {
        $this->status = $status;
        return $this;
    }

    public function getLocationId(): ?int
    {
        return $this->location_id;
    }

    public function setLocationId(?int $location_id): self
    {
        $this->location_id = $location_id;
        return $this;
    }

    public function getCallNumber(): ?string
    {
        return $this->call_number;
    }

    public function setCallNumber(?string $call_number): self
    {
        $this->call_number = $call_number;
        return $this;
    }

    public function getAcquisitionDate(): ?\DateTimeInterface
    {
        return $this->acquisition_date;
    }

    public function setAcquisitionDate(?\DateTimeInterface $acquisition_date): self
    {
        $this->acquisition_date = $acquisition_date;
        return $this;
    }

    public function getReturnDate(): ?\DateTimeInterface
    {
        return $this->returnDate;
    }

    public function setReturnDate(?\DateTimeInterface $returnDate): self
    {
        $this->returnDate = $returnDate;
        return $this;
    }

    public function getPrice(): ?string
    {
        return $this->price;
    }

    public function setPrice(?string $price): self
    {
        $this->price = $price;
        return $this;
    }

    public function getComment(): ?string
    {
        return $this->comment;
    }

    public function setComment(?string $comment): self
    {
        $this->comment = $comment;
        return $this;
    }
} 