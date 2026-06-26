# Project Structure

## Purpose

This document defines the recommended project structure for the DscienTia platform.

Its purpose is to ensure:

* Consistent development practices
* Scalable architecture
* Maintainable codebase
* Clear separation of responsibilities

This structure should be followed by all future development efforts.

---

# Architectural Principles

The project structure is based on:

* Clean Architecture
* Feature-Based Organization
* Separation of Concerns
* API-First Development
* Modular Design

---

# Repository Structure

```text
dscientia-mobile/
│
├── docs/
├── mobile/
├── backend/
├── database/
├── infrastructure/
└── assets/
```

---

# Documentation Layer

Location:

```text
docs/
```

Purpose:

* Product documentation
* Architecture documentation
* AI documentation
* Development standards

Subfolders:

```text
docs/
├── architecture/
├── ai/
├── wireframes/
├── mvp/
├── diagrams/
├── roadmap/
└── development/
```

---

# Mobile Application

Location:

```text
mobile/
```

Technology:

```text
Flutter
Dart
```

---

# Flutter Structure

```text
mobile/
└── lib/
    │
    ├── core/
    ├── shared/
    ├── features/
    ├── routes/
    ├── config/
    └── main.dart
```

---

# Core Layer

Location:

```text
lib/core/
```

Purpose:

Contains application-wide functionality.

Examples:

```text
core/
├── constants/
├── exceptions/
├── services/
├── network/
├── storage/
├── theme/
└── utils/
```

---

# Shared Layer

Location:

```text
lib/shared/
```

Purpose:

Reusable components shared across features.

Examples:

```text
shared/
├── widgets/
├── models/
├── extensions/
└── helpers/
```

---

# Feature Layer

Location:

```text
lib/features/
```

Purpose:

Business features are isolated into independent modules.

---

# Feature Modules

```text
features/
├── auth/
├── dashboard/
├── projects/
├── reports/
├── insights/
├── risks/
└── recommendations/
```

---

# Standard Feature Structure

Every feature should follow:

```text
feature_name/
│
├── data/
├── domain/
├── presentation/
└── application/
```

---

# Data Layer

Responsibilities:

* API calls
* DTOs
* Repositories

Example:

```text
reports/data/
├── datasources/
├── models/
└── repositories/
```

---

# Domain Layer

Responsibilities:

* Business entities
* Business rules
* Use cases

Example:

```text
reports/domain/
├── entities/
├── repositories/
└── usecases/
```

---

# Application Layer

Responsibilities:

* State management
* Controllers
* Providers

Example:

```text
reports/application/
├── providers/
├── controllers/
└── states/
```

---

# Presentation Layer

Responsibilities:

* Screens
* Widgets
* User interaction

Example:

```text
reports/presentation/
├── screens/
├── widgets/
└── dialogs/
```

---

# Routing

Location:

```text
lib/routes/
```

Technology:

```text
GoRouter
```

Example:

```text
routes/
├── app_router.dart
├── auth_routes.dart
└── project_routes.dart
```

---

# Configuration

Location:

```text
lib/config/
```

Purpose:

Environment configuration.

Example:

```text
config/
├── environments/
├── app_config.dart
└── api_config.dart
```

---

# Backend Structure

Location:

```text
backend/
```

Technology:

```text
Laravel 12
```

---

# Laravel Structure

```text
backend/
├── app/
├── routes/
├── database/
├── config/
├── tests/
└── storage/
```

---

# Application Layer

Location:

```text
app/
```

Recommended organization:

```text
app/
├── Http/
├── Services/
├── Repositories/
├── Models/
├── Policies/
└── Jobs/
```

---

# Controllers

Location:

```text
app/Http/Controllers/
```

Examples:

```text
AuthController
ProjectController
ReportController
InsightController
RiskController
RecommendationController
```

---

# Services

Location:

```text
app/Services/
```

Purpose:

Contains business logic.

Examples:

```text
InsightService
RiskAssessmentService
RecommendationService
WatsonxService
```

---

# Repositories

Location:

```text
app/Repositories/
```

Purpose:

Database abstraction layer.

Examples:

```text
ProjectRepository
ReportRepository
InsightRepository
```

---

# Database Structure

Location:

```text
database/
```

Purpose:

Database assets and schema definitions.

Example:

```text
database/
├── schema/
├── migrations/
├── seeders/
└── backups/
```

---

# PostgreSQL Design

Primary Database:

```text
PostgreSQL
```

Future:

```text
PostGIS
```

Use Cases:

* Geospatial analytics
* Community mapping
* Risk visualization

---

# Infrastructure Layer

Location:

```text
infrastructure/
```

Purpose:

Deployment and environment configuration.

Example:

```text
infrastructure/
├── docker/
├── ci-cd/
├── monitoring/
└── scripts/
```

---

# AI Integration Structure

Location:

```text
backend/app/Services/AI/
```

Example:

```text
AI/
├── WatsonxService.php
├── PromptBuilder.php
├── InsightGenerator.php
├── RiskAnalyzer.php
└── RecommendationEngine.php
```

---

# Prompt Assets

Location:

```text
backend/resources/prompts/
```

Example:

```text
prompts/
├── insight_prompt.txt
├── risk_prompt.txt
└── recommendation_prompt.txt
```

---

# Asset Structure

Location:

```text
assets/
```

Example:

```text
assets/
├── images/
├── icons/
├── illustrations/
└── datasets/
```

---

# Naming Conventions

## Flutter

Files:

```text
snake_case.dart
```

Classes:

```text
PascalCase
```

Variables:

```text
camelCase
```

---

## Laravel

Controllers:

```text
ProjectController
```

Services:

```text
ProjectService
```

Repositories:

```text
ProjectRepository
```

---

## Database

Tables:

```text
snake_case
```

Examples:

```text
users
projects
reports
ai_insights
risk_assessments
recommendations
```

---

# Future Expansion

Future modules may include:

```text
analytics/
research/
geospatial/
notifications/
collaboration/
```

without requiring major structural changes.

---

# Related Documents

* System Architecture
* Architecture v1
* Domain Model
* Data Models
* API Specification v1

---

# Version

Project Structure v1

Created: June 2026

Project:

DscienTia — AI-Powered Community Impact Intelligence Platform
