# DscienTia Architecture v1

## Overview

This document provides a high-level architecture overview of the DscienTia platform.

It serves as a visual and technical reference for:

* Product stakeholders
* Developers
* System architects
* AI-assisted development tools

The architecture is designed around the principles of:

* Mobile First
* API First
* AI Powered
* Security by Design
* Scalable by Design

---

# Architecture Summary

DscienTia follows a layered architecture that separates:

1. User Experience Layer
2. Application Layer
3. Data Layer
4. Intelligence Layer

This separation enables scalability, maintainability, and future expansion.

---

# High-Level Architecture

```text id="arch01"
┌─────────────────────────────────────┐
│           Mobile Client             │
│              Flutter                │
└─────────────────┬───────────────────┘
                  │
                  ▼
┌─────────────────────────────────────┐
│            Laravel API              │
│         Application Layer           │
└─────────────────┬───────────────────┘
                  │
      ┌───────────┴───────────┐
      ▼                       ▼
┌──────────────┐     ┌────────────────┐
│ PostgreSQL   │     │ IBM watsonx.ai │
│ Data Layer   │     │ AI Layer       │
└──────────────┘     └────────────────┘
```

---

# Layer Architecture

## User Experience Layer

Technology:

* Flutter
* Dart

Responsibilities:

* User authentication
* Project monitoring
* Community reporting
* AI insight visualization
* Risk visualization
* Recommendation display

Screens:

* Login
* Dashboard
* Submit Report
* AI Insight Center
* Risk Assessment
* Recommendation Center
* Project Detail

---

## Application Layer

Technology:

* Laravel 12

Responsibilities:

* Authentication
* Business logic
* API management
* Data validation
* AI orchestration

Key Services:

```text id="svc01"
Auth Service
Project Service
Report Service
Insight Service
Risk Service
Recommendation Service
```

---

## Data Layer

Technology:

* PostgreSQL

Future Expansion:

* PostGIS

Responsibilities:

* User management
* Project storage
* Report storage
* AI result storage
* Analytics support

---

## Intelligence Layer

Technology:

* IBM Granite Models
* IBM watsonx.ai

Responsibilities:

* Insight generation
* Risk assessment
* Recommendation generation
* Text summarization

---

# Data Flow

## Community Intelligence Workflow

```text id="flow01"
User
 ↓
Submit Report
 ↓
Laravel API
 ↓
PostgreSQL
 ↓
AI Analysis Request
 ↓
IBM watsonx
 ↓
AI Insight
 ↓
Risk Assessment
 ↓
Recommendations
 ↓
Flutter Dashboard
```

---

# Core Business Entities

The MVP revolves around the following entities:

```text id="entity01"
User
Community
Project
Report
AIInsight
RiskAssessment
Recommendation
```

Detailed definitions are available in:

```text id="entity02"
docs/architecture/Domain-Model.md
```

---

# API Communication

The mobile application communicates exclusively through REST APIs.

```text id="api01"
Flutter
 ↓
REST API
 ↓
Laravel
```

Direct database access from the client is not allowed.

Benefits:

* Security
* Maintainability
* Scalability
* Version control

---

# AI Processing Flow

## Insight Generation

Input:

```text id="ai01"
Community Reports
Project Information
Historical Context
```

Processing:

```text id="ai02"
Prompt Construction
↓
IBM Granite
↓
Insight Extraction
```

Output:

```text id="ai03"
Insight Summary
Confidence Score
Supporting Evidence
```

---

## Risk Assessment

Input:

```text id="risk01"
Community Data
Project Metrics
Historical Trends
```

Output:

```text id="risk02"
Risk Score
Risk Category
Priority Level
```

---

## Recommendation Engine

Input:

```text id="rec01"
Insights
Risk Assessment
Project Context
```

Output:

```text id="rec02"
Action Recommendations
Priority Ranking
Expected Impact
```

---

# Security Architecture

Security responsibilities are distributed across all layers.

## Mobile Layer

* Secure token storage
* Session management
* Input validation

---

## API Layer

* Authentication
* Authorization
* Request validation
* Rate limiting

---

## Database Layer

* Access control
* Backup strategy
* Data integrity

---

## AI Layer

* Prompt governance
* Output validation
* Responsible AI principles

---

# Technology Stack

## Frontend

```text id="stack01"
Flutter
Dart
Riverpod
GoRouter
```

---

## Backend

```text id="stack02"
Laravel 12
PHP
REST API
```

---

## Database

```text id="stack03"
PostgreSQL
```

Future:

```text id="stack04"
PostGIS
```

---

## Artificial Intelligence

```text id="stack05"
IBM Granite
IBM watsonx.ai
```

---

# Architecture Principles

## Mobile First

The mobile application is the primary user interface.

---

## API First

All platform functionality must be accessible through APIs.

---

## AI Powered

Artificial intelligence is a core platform capability.

---

## Modular Design

Features should remain independent and loosely coupled.

---

## Scalability

The architecture must support future expansion without major redesign.

---

# Related Documents

Product Vision:

```text id="rel01"
docs/roadmap/Product-Vision.md
```

System Architecture:

```text id="rel02"
docs/architecture/System-Architecture.md
```

AI Architecture:

```text id="rel03"
docs/ai/AI-Architecture.md
```

Domain Model:

```text id="rel04"
docs/architecture/Domain-Model.md
```

API Specification:

```text id="rel05"
docs/mvp/API-Specification-v1.md
```

---

# Version

Architecture Diagram v1

Created: June 2026

Project:

DscienTia — AI-Powered Community Impact Intelligence Platform
