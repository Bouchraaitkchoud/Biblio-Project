<?php

// src/Entity/Receipt.php
namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;

#[ORM\Entity]
class Receipt
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column]
    private ?int $id = null;

    #[ORM\OneToOne(targetEntity: BorrowingRequest::class, inversedBy: 'receipt')]
    #[ORM\JoinColumn(nullable: false)]
    private ?BorrowingRequest $borrowingRequest = null;

    #[ORM\Column(length: 255)]
    private ?string $code = null; // Unique receipt code

    // Getters and setters
    public function getId(): ?int
    {
        return $this->id;
    }

    public function getBorrowingRequest(): ?BorrowingRequest
    {
        return $this->borrowingRequest;
    }

    public function setBorrowingRequest(?BorrowingRequest $borrowingRequest): self
    {
        $this->borrowingRequest = $borrowingRequest;
        return $this;
    }

    public function getCode(): ?string
    {
        return $this->code;
    }

    public function setCode(string $code): self
    {
        $this->code = $code;
        return $this;
    }
}
