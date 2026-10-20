# Student Housing System
# pending-approval
## Project Overview
Student Housing System is a graduation project for a web-based property rental platform.

The system helps:
- normal tenants
- student tenants
- property owners
- admin

Students can search for student-friendly properties and view special discounts, while property owners can add and manage their properties.

## Technologies Used
- Frontend: React, HTML, CSS, JavaScript
- Backend: Laravel
- Database: MySQL

## Project Structure
bash
student-housing-system/
├── BackEnd/
└── FrontEnd/   (to be added later)

## Current Backend Progress
Completed database tables:
- users
- universities
- properties
- property_images
- contact_requests

Completed relationships:
- users -> universities
- properties -> users
- properties -> universities
- property_images -> properties
- contact_requests -> properties
- contact_requests -> users

## How to Run the Backend
1. Open terminal inside `BackEnd`
2. Install dependencies:
bash
composer install

3. Copy `.env.example` to `.env`
4. Configure database settings
5. Run migrations:
bash
php artisan migrate

6. Start server:
bash
php artisan serve

## Status
Backend database design and relationships are completed.
Next steps:
- create models
- define Laravel relationships
- build authentication
- create APIs