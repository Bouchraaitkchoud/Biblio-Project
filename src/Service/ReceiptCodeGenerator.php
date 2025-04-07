<?php
// src/Service/ReceiptCodeGenerator.php
namespace App\Service;

class ReceiptCodeGenerator
{
    public function generateCode(): string
    {
        // Example: Generate a random 8-character alphanumeric code
        return substr(str_shuffle('ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789'), 0, 8);
    }
}