<?php
require dirname(__DIR__).'/vendor/autoload.php';

use Knp\Snappy\Pdf;

// Create PDF instance with full path
$snappy = new Pdf('"C:\Program Files\wkhtmltopdf\bin\wkhtmltopdf.exe"');

// Simple HTML content
$html = '
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Test PDF</title>
</head>
<body>
    <h1>Test PDF Generation</h1>
    <p>This is a test PDF generated at: ' . date('Y-m-d H:i:s') . '</p>
</body>
</html>
';

try {
    // Generate PDF
    $pdf = $snappy->getOutputFromHtml($html);
    
    // Output PDF
    header('Content-Type: application/pdf');
    header('Content-Disposition: inline; filename="test.pdf"');
    echo $pdf;
} catch (\Exception $e) {
    // If there's an error, show it
    header('Content-Type: text/plain');
    echo "Error generating PDF:\n";
    echo $e->getMessage();
} 