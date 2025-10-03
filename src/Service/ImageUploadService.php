<?php

namespace App\Service;

use Symfony\Component\HttpFoundation\File\Exception\FileException;
use Symfony\Component\HttpFoundation\File\UploadedFile;
use Symfony\Component\String\Slugger\SluggerInterface;

class ImageUploadService
{
    private $disciplinesDirectory;
    private $bookCoversDirectory;
    private $slugger;

    public function __construct(string $disciplinesDirectory, string $bookCoversDirectory, SluggerInterface $slugger)
    {
        $this->disciplinesDirectory = $disciplinesDirectory;
        $this->bookCoversDirectory = $bookCoversDirectory;
        $this->slugger = $slugger;
    }

    public function uploadDiscipline(UploadedFile $file, string $disciplineName): string
    {
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($disciplineName);
        $fileName = $safeFilename.'-'.uniqid().'.'.$file->guessExtension();

        try {
            $file->move($this->disciplinesDirectory, $fileName);
        } catch (FileException $e) {
            throw new \Exception('Erreur lors de l\'upload de l\'image: ' . $e->getMessage());
        }

        return $fileName;
    }

    public function uploadBookCover(UploadedFile $file, string $bookTitle): string
    {
        $originalFilename = pathinfo($file->getClientOriginalName(), PATHINFO_FILENAME);
        $safeFilename = $this->slugger->slug($bookTitle);
        $fileName = $safeFilename.'-'.uniqid().'.'.$file->guessExtension();

        try {
            $file->move($this->bookCoversDirectory, $fileName);
        } catch (FileException $e) {
            throw new \Exception('Erreur lors de l\'upload de la couverture: ' . $e->getMessage());
        }

        return $fileName;
    }

    // Legacy method for backward compatibility
    public function upload(UploadedFile $file, string $name): string
    {
        return $this->uploadDiscipline($file, $name);
    }

    public function deleteDiscipline(string $filename): bool
    {
        if (!$filename) {
            return true;
        }

        $filePath = $this->disciplinesDirectory . '/' . $filename;
        
        if (file_exists($filePath)) {
            return unlink($filePath);
        }
        
        return true;
    }

    public function deleteBookCover(string $filename): bool
    {
        if (!$filename) {
            return true;
        }

        $filePath = $this->bookCoversDirectory . '/' . $filename;
        
        if (file_exists($filePath)) {
            return unlink($filePath);
        }
        
        return true;
    }

    // Legacy method for backward compatibility
    public function delete(string $filename): bool
    {
        return $this->deleteDiscipline($filename);
    }

    public function getUploadDirectory(): string
    {
        return $this->disciplinesDirectory;
    }
}