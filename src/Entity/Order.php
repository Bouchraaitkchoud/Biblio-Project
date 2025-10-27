<?php
namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Repository\OrderRepository;
use App\Entity\Exemplaire;

#[ORM\Entity(repositoryClass: OrderRepository::class)]
#[ORM\Table(name: "orders")]
class Order
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type:"integer")]
    private ?int $id = null;

    #[ORM\ManyToOne(targetEntity: User::class)]
    #[ORM\JoinColumn(nullable:false)]
    private ?User $user = null;

    #[ORM\Column(type:"datetime")]
    private ?\DateTimeInterface $placedAt = null;

    #[ORM\Column(type:"datetime", nullable:true)]
    private ?\DateTimeInterface $processedAt = null;

    #[ORM\Column(type:"string", length:20)]
    private ?string $status = null;

    #[ORM\Column(type:"string", length:50, nullable:true)]
    private ?string $receiptCode = null;

    // This field can store details of the order (for example, an array of items or a JSON snapshot)
    #[ORM\Column(type:"json", nullable:true)]
    private ?array $orderDetails = [];

    #[ORM\Column(type:"string", length:100, nullable:true)]
    private ?string $adminEmail = null;

    #[ORM\ManyToOne(targetEntity: Exemplaire::class)]
    #[ORM\JoinColumn(nullable: false)]
    private ?Exemplaire $exemplaire = null;

    #[ORM\Column(type: 'datetime', nullable: true)]
    private ?\DateTimeInterface $returnedAt = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getUser(): ?User
    {
        return $this->user;
    }

    public function setUser(?User $user): self
    {
        $this->user = $user;
        return $this;
    }

    public function getPlacedAt(): ?\DateTimeInterface
    {
        return $this->placedAt;
    }

    public function setPlacedAt(\DateTimeInterface $placedAt): self
    {
        $this->placedAt = $placedAt;
        return $this;
    }

    public function getProcessedAt(): ?\DateTimeInterface
    {
        return $this->processedAt;
    }

    public function setProcessedAt(?\DateTimeInterface $processedAt): self
    {
        $this->processedAt = $processedAt;
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

    public function getReceiptCode(): ?string
    {
        return $this->receiptCode;
    }

    public function setReceiptCode(?string $receiptCode): self
    {
        $this->receiptCode = $receiptCode;
        return $this;
    }

    public function getOrderDetails(): ?array
    {
        return $this->orderDetails;
    }

    public function setOrderDetails(?array $orderDetails): self
    {
        $this->orderDetails = $orderDetails;
        return $this;
    }

    public function getAdminEmail(): ?string
    {
        return $this->adminEmail;
    }

    public function setAdminEmail(?string $adminEmail): self
    {
        $this->adminEmail = $adminEmail;
        return $this;
    }

    public function getExemplaire(): ?Exemplaire
    {
        return $this->exemplaire;
    }

    public function setExemplaire(?Exemplaire $exemplaire): self
    {
        $this->exemplaire = $exemplaire;
        return $this;
    }

    public function getReturnedAt(): ?\DateTimeInterface
    {
        return $this->returnedAt;
    }

    public function setReturnedAt(?\DateTimeInterface $returnedAt): self
    {
        $this->returnedAt = $returnedAt;
        return $this;
    }
}

