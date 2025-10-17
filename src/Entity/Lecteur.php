<?php


namespace App\Entity;

use Doctrine\ORM\Mapping as ORM;
use App\Repository\LecteurRepository;

#[ORM\Entity(repositoryClass: LecteurRepository::class)]
class Lecteur
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type:"integer")]
    private ?int $id = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $nom = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $prenom = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $codeAdmission = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $etablissement = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $formation = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $promotion = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $email = null;

    #[ORM\Column(type:"string", length:255)]
    private ?string $password = null;

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): self
    {
        $this->nom = $nom;
        return $this;
    }

    public function getPrenom(): ?string
    {
        return $this->prenom;
    }

    public function setPrenom(string $prenom): self
    {
        $this->prenom = $prenom;
        return $this;
    }

    public function getCodeAdmission(): ?string
    {
        return $this->codeAdmission;
    }

    public function setCodeAdmission(string $codeAdmission): self
    {
        $this->codeAdmission = $codeAdmission;
        return $this;
    }

    public function getEtablissement(): ?string
    {
        return $this->etablissement;
    }

    public function setEtablissement(string $etablissement): self
    {
        $this->etablissement = $etablissement;
        return $this;
    }

    public function getFormation(): ?string
    {
        return $this->formation;
    }

    public function setFormation(string $formation): self
    {
        $this->formation = $formation;
        return $this;
    }

    public function getPromotion(): ?string
    {
        return $this->promotion;
    }

    public function setPromotion(string $promotion): self
    {
        $this->promotion = $promotion;
        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): self
    {
        $this->email = $email;
        return $this;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(string $password): self
    {
        $this->password = $password;
        return $this;
    }
}