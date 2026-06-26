# DscienTia Documentation Portal

## Overview

Welcome to the DscienTia documentation repository.

This documentation serves as the primary source of truth for the design, architecture, AI strategy, user experience, and implementation roadmap of the DscienTia platform.

DscienTia is an AI-powered Community Impact Intelligence Platform designed to help NGOs, foundations, community leaders, researchers, and volunteers transform community data into actionable intelligence.

The platform combines:

* Community reporting
* Project monitoring
* AI-generated insights
* Risk assessment
* Decision support recommendations

to improve social impact outcomes.

---

# Documentation Structure

```text
docs/
├── architecture/
├── ai/
├── wireframes/
├── mvp/
├── roadmap/
├── diagrams/
└── development/
```

---

# Documentation Navigation

## Product & Strategy

Provides the strategic foundation of the platform.

Location:

```text
docs/roadmap/
```

Documents:

| Document                      | Purpose                                   |
| ----------------------------- | ----------------------------------------- |
| Product-Vision.md             | Defines the long-term vision of DscienTia |
| Sprint-Plan-v1.md             | Defines MVP implementation sprints        |
| MVP-Implementation-Roadmap.md | Defines the overall delivery roadmap      |

---

# User Experience & Product Design

Defines users, navigation, and interaction flows.

Location:

```text
docs/architecture/
docs/wireframes/
```

---

## User Personas

Document:

```text
docs/architecture/User-Personas.md
```

Defines:

* Volunteers
* Community Leaders
* NGO Managers
* Social Researchers

---

## Information Architecture

Document:

```text
docs/architecture/Information-Architecture.md
```

Defines:

* Navigation hierarchy
* Feature organization
* Information flow

---

## UX Wireframes

Location:

```text
docs/wireframes/screens/
```

Available Screens:

| Screen                |
| --------------------- |
| Login                 |
| Dashboard             |
| Submit Report         |
| AI Insight Center     |
| Risk Assessment       |
| Recommendation Center |
| Project Detail        |

---

# System Architecture

Defines the technical blueprint of the platform.

Location:

```text
docs/architecture/
```

---

## System Architecture

Document:

```text
docs/architecture/System-Architecture.md
```

Defines:

* High-level architecture
* Backend services
* Data architecture
* AI integration strategy

---

## ADR-001 Mobile Platform Strategy

Document:

```text
docs/architecture/ADR-001-Mobile-Platform-Strategy.md
```

Defines:

* Mobile-first strategy
* Flutter architecture decisions
* Offline-first requirements

---

## Domain Model

Document:

```text
docs/architecture/Domain-Model.md
```

Defines core business entities:

* User
* Community
* Project
* Report
* AI Insight
* Risk Assessment
* Recommendation

---

# Artificial Intelligence Documentation

Defines the intelligence layer of DscienTia.

Location:

```text
docs/ai/
```

---

## AI Use Cases

Document:

```text
docs/ai/AI-Use-Cases.md
```

Defines:

* Community intelligence scenarios
* Insight generation
* Risk assessment
* Recommendation workflows

---

## AI Data Pipeline

Document:

```text
docs/ai/AI-Data-Pipeline.md
```

Defines:

* Data ingestion
* Processing workflow
* AI input preparation

---

## AI Architecture

Document:

```text
docs/ai/AI-Architecture.md
```

Defines:

* AI service architecture
* Granite integration
* Intelligence workflows

---

## Risk Scoring Model

Document:

```text
docs/ai/Risk-Scoring-Model.md
```

Defines:

* Risk categories
* Scoring methodology
* Risk classification

---

## Prompt Engineering

Document:

```text
docs/ai/Prompt-Engineering.md
```

Defines:

* Prompt design strategy
* Context management
* Response quality standards

---

## IBM watsonx Integration

Document:

```text
docs/ai/IBM-WatsonX-Integration.md
```

Defines:

* IBM Granite usage
* watsonx.ai integration
* AI deployment workflows

---

# MVP Documentation

Defines the implementation blueprint for the first production-ready MVP.

Location:

```text
docs/mvp/
```

---

## MVP Scope

Defines:

* Included features
* Excluded features
* Success criteria

---

## User Journeys

Defines:

* Volunteer workflows
* NGO workflows
* Research workflows

---

## Navigation Flows

Defines:

* Screen transitions
* User interaction paths

---

## AI Insight Workflow

Defines:

* Report processing
* AI analysis flow
* Insight generation

---

## Data Models

Defines:

* Database entities
* Relationships
* Data ownership

---

## API Contracts

Defines:

* Service communication
* High-level API behavior

---

## API Specification v1

Defines:

* Endpoints
* Requests
* Responses
* Status codes

---

## AI Prompt Templates

Defines:

* Insight prompts
* Risk prompts
* Recommendation prompts

---

## Mock AI Responses

Defines:

* Expected AI outputs
* Insight examples
* Recommendation examples

---

# Technical Design

Provides implementation-ready technical specifications.

Location:

```text
docs/diagrams/
docs/development/
```

---

## ERD v1

Document:

```text
docs/diagrams/ERD-v1.md
```

Defines:

* Entity relationships
* Database structure
* MVP schema

---

## Architecture Diagram

Document:

```text
docs/diagrams/Architecture-v1.md
```

Defines:

* System interactions
* Technology stack
* Service boundaries

---

## Development Standards

Location:

```text
docs/development/
```

Documents:

* Project-Structure.md
* Engineering-Standards.md
* Definition-of-Done.md

These documents establish implementation standards and engineering practices for future development.

---

# Technology Stack

## Mobile

* Flutter
* Dart

---

## Backend

* Laravel 12
* PHP

---

## Database

* PostgreSQL

Future:

* PostgreSQL + PostGIS

---

## AI

Primary:

* IBM Granite Models
* IBM watsonx.ai

Future:

* Open-source LLMs
* Domain-specific intelligence models

---

# Current Project Status

## Completed

### v0.1 Foundation

* Product Vision
* Strategic Direction

### v0.2 Product Design

* Personas
* Information Architecture
* Domain Model
* System Architecture

### v0.3 AI Transformation

* AI-first platform evolution

### v0.4 UX Wireframes

* Complete MVP screen specifications

### v0.5 Data & AI Design

* AI Architecture
* Data Pipeline
* Prompt Engineering
* IBM watsonx Integration

### v0.6 AI Insight MVP

* MVP Scope
* User Journeys
* API Design
* AI Workflows
* Technical Specifications

---

# Next Milestones

## v0.7 Flutter Foundation

Objectives:

* Flutter architecture
* Navigation
* Authentication UI
* Dashboard foundation

---

## v0.8 Backend Services

Objectives:

* Laravel APIs
* PostgreSQL integration
* Authentication services
* Report services

---

## v0.9 AI Integration

Objectives:

* IBM Granite integration
* AI Insight generation
* Risk assessment engine
* Recommendation engine

---

## v1.0 Demo Release

Objectives:

* End-to-end MVP
* IBM Challenge submission
* Demo environment
* Presentation assets

---

# Guiding Principles

DscienTia follows the following principles:

* Mobile First
* Offline First
* API First
* AI Ready
* Security by Design
* Scalable by Design

These principles should guide all future architectural and implementation decisions.

---

# Version

Documentation Portal v1

Created: June 2026

Project:

DscienTia — AI-Powered Community Impact Intelligence Platform
