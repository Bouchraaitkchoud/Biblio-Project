<?php

namespace App\Entity;

use App\Repository\UserRepository;
use Doctrine\Common\Collections\Collection;
use Doctrine\Common\Collections\ArrayCollection;
use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Security\Core\User\PasswordAuthenticatedUserInterface;
use Symfony\Component\Security\Core\User\UserInterface;

#[ORM\Entity(repositoryClass: UserRepository::class)]
#[ORM\Table(name: '`user`')]
#[ORM\UniqueConstraint(name: 'UNIQ_IDENTIFIER_EMAIL', fields: ['email'])]
#[UniqueEntity(fields: ['email'], message: 'There is already an account with this email')]
class User implements UserInterface, PasswordAuthenticatedUserInterface
{
    #[ORM\Id]
    #[ORM\GeneratedValue]
    #[ORM\Column(type: 'integer')]
    private ?int $id = null;

    #[ORM\Column(type: 'string', length: 255, unique: true)]
    private ?string $login = null;

    #[ORM\Column(type: 'string')]
    private ?string $nom = null;

    #[ORM\Column(type: 'string')]
    private ?string $prenom = null;

    #[ORM\Column(length: 180)]
    private ?string $email = null;

    #[ORM\OneToMany(targetEntity: Cart::class, mappedBy: 'user')]
    private Collection $carts;

    #[ORM\Column(type: 'json')]
    private array $roles = [];

    #[ORM\Column(type: 'string')]
    private ?string $password = null;

    public function __construct()
    {
        $this->carts = new ArrayCollection();
    }

    public function getId(): ?int
    {
        return $this->id;
    }

    public function getLogin(): ?string
    {
        return $this->login;
    }

    public function setLogin(string $login): self
    {
        $this->login = $login;

        return $this;
    }

    public function getNom(): ?string
    {
        return $this->nom;
    }

    public function setNom(string $nom): static
    {
        $this->nom = $nom;

        return $this;
    }

    public function getPrenom(): ?string
    {
        return $this->prenom;
    }

    public function setPrenom(string $prenom): static
    {
        $this->prenom = $prenom;

        return $this;
    }

    public function getEmail(): ?string
    {
        return $this->email;
    }

    public function setEmail(string $email): static
    {
        $this->email = $email;

        return $this;
    }

    public function getUserIdentifier(): string
    {
        return (string) $this->email;
    }

    public function getRoles(): array
    {
        $roles = $this->roles;
        // guarantee every user gets at least ROLE_USER
        if (!in_array('ROLE_USER', $roles, true)) {
            $roles[] = 'ROLE_USER';
        }
        return array_unique($roles);
    }

    public function setRoles(array $roles): static
    {
        $this->roles = $roles;

        return $this;
    }

    public function getPassword(): ?string
    {
        return $this->password;
    }

    public function setPassword(string $password): static
    {
        $this->password = $password;

        return $this;
    }

    public function eraseCredentials(): void
    {
    }

    public function getCarts(): Collection
    {
        return $this->carts;
    }

    public function addCart(Cart $cart): self
    {
        if (!$this->carts->contains($cart)) {
            $this->carts->add($cart);
            $cart->setUser($this);
        }
        return $this;
    }

    public function getLastCart(): ?Cart
    {
        return $this->carts->last();
    }

    /**
     * Get user admin type label
     */
    public function getAdminType(): string
    {
        if (in_array('ROLE_ADMIN', $this->roles)) {
            return 'Admin Absolu';
        } elseif (in_array('ROLE_LIMITED_ADMIN', $this->roles)) {
            return 'Admin Limité';
        }
        return 'Utilisateur';
    }

    /**
     * Get readable permission labels
     */
    public function getPermissionsLabels(): array
    {
        $roleMap = [
            'ROLE_GERER_LIVRES' => 'Livres',
            'ROLE_GERER_AUTEURS' => 'Auteurs',
            'ROLE_GERER_UTILISATEURS' => 'Utilisateurs',
            'ROLE_GERER_LECTEURS' => 'Lecteurs',
            'ROLE_GERER_DISCIPLINES' => 'Disciplines',
            'ROLE_GERER_EDITEURS' => 'Éditeurs',
            'ROLE_GERER_RETOURS' => 'Retours',
            'ROLE_GERER_COMMANDES' => 'Commandes',
            'ROLE_GERER_HISTORIQUE' => 'Historique',
        ];

        $labels = [];
        foreach ($this->roles as $role) {
            if (isset($roleMap[$role])) {
                $labels[] = $roleMap[$role];
            }
        }
        return $labels;
    }

    /**
     * Check if user has a specific permission
     */
    public function hasPermission(string $role): bool
    {
        return in_array($role, $this->roles);
    }
}
