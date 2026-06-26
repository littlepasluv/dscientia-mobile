# DscienTia Repository Strategy

## Version

v1.0

Date: June 2026

---

# Purpose

This document defines the official repository strategy for DscienTia.

The objective is to ensure:

* Consistent project organization
* AI-agent-friendly structure
* Scalable architecture
* Clear separation of responsibilities

---

# Repository Model

## Selected Strategy

Monorepo

---

# Rationale

DscienTia consists of tightly integrated components:

* Flutter Mobile Application
* Laravel API Backend
* PostgreSQL Database
* IBM watsonx AI Services

Maintaining all components inside a single repository provides:

* Easier onboarding
* Better documentation visibility
* Simpler CI/CD
* Better AI-assisted development
* Easier hackathon submission

---

# Repository Structure

```text id="9c4rrj"
dscientia/

├── docs/

├── frontend/

├── backend/

├── database/

├── infrastructure/

└── .github/
```

---

# Documentation Layer

```text id="v1nhzg"
docs/
```

Purpose:

Single source of truth.

Contains:

* Product vision
* Architecture
* AI design
* API design
* Data design
* Governance

No implementation code should exist inside docs.

---

# Frontend Layer

```text id="c9xluu"
frontend/
```

Technology:

Flutter

Purpose:

Mobile application implementation.

Expected Structure:

```text id="97n45f"
frontend/

lib/

core/

features/

shared/

services/

routes/
```

---

# Backend Layer

```text id="dchj16"
backend/
```

Technology:

Laravel 12

Purpose:

Business logic and APIs.

Expected Structure:

```text id="y0lzke"
backend/

app/

routes/

database/

tests/
```

---

# Database Layer

```text id="oqg0wr"
database/
```

Purpose:

Database-specific assets.

Contents:

```text id="3utgxt"
schema/

seeders/

erd/

migration-reference/
```

---

# Infrastructure Layer

```text id="z9muws"
infrastructure/
```

Purpose:

Deployment and operational configuration.

Examples:

```text id="x1g7sa"
docker/

nginx/

monitoring/

cloud/
```

---

# GitHub Layer

```text id="4n8j1g"
.github/
```

Purpose:

Automation.

Contents:

```text id="k1h62s"
workflows/

issue templates/

pull request templates/
```

---

# Branch Strategy

## Protected Branches

```text id="8y7kb8"
main
develop
```

---

## Feature Branches

Format:

```text id="1t6t6m"
feature/<feature-name>
```

Examples:

```text id="32i4nn"
feature/flutter-foundation

feature/authentication

feature/ai-insight
```

---

## Bug Fixes

Format:

```text id="9m5m6u"
bugfix/<issue>
```

---

## Hot Fixes

Format:

```text id="5u93s4"
hotfix/<issue>
```

---

# Merge Policy

Requirements before merge:

* Documentation updated
* Code reviewed
* Tests passing
* Architecture compliance verified

---

# AI Agent Guidelines

When generating code:

* Respect repository boundaries.
* Do not place frontend code inside backend.
* Do not place backend code inside frontend.
* Do not place implementation code inside docs.
* Follow approved project structure.
* Follow Technology Stack Decision.
* Follow Engineering Standards.

---

# Future Scalability

If DscienTia evolves into a larger platform:

Possible future extraction:

```text id="91y51v"
dscientia-mobile

dscientia-api

dscientia-ai
```

However, this should not occur before post-MVP stages.

Current recommendation:

Remain Monorepo.

---

# Official Repository Decision

Repository Model:

Monorepo

Frontend:

Flutter

Backend:

Laravel

Database:

PostgreSQL

AI:

IBM watsonx

Version Control:

GitHub

---

End of Document
