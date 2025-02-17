
# UBIB

UBIB is a book loan platform for the University of Abulcasis. This project was developed as part of an internship. The platform allows students to browse available books and request loans. There are two main interfaces in the system: the Admin Interface for managing books and loans, and the Student Interface for browsing the catalog and making loan requests.

## Features

-  Book Catalogue: Browse and search for available books.
-  Book Loan Process: Request and manage book loans.
- Admin Management: Administrators can manage books, students, and loan requests.
- Student Requests: Students can view available books and request a loan from a specific library location.


## Prerequisites

Ensure you have the following installed:

- Symfony (for the backend)
- React (for the frontend)
-Node.js (16+ recommended for React)
-Composer (for Symfony)
-MySQL/PostgreSQL (for the database) 

## Installation

1. Clone the repository
   Clone the repository from GitHub:

      git clone https://github.com/Bouchraaitkchoud/Biblio-Project.git
      cd Biblio-Project


2. nstall the Backend (Symfony)
   Navigate to the backend directory and install the dependencies:

      cd backend
      composer install
      cp .env.example .env
      php bin/console cache:clear
      php bin/console doctrine:database:create   # (if using a database)
      php bin/console doctrine:migrations:migrate
     
3.Install the Frontend (React)
   Navigate to the frontend directory and install the dependencies:
       cd ../frontend
       npm install



      





  
