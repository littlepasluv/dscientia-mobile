# Engineering Standards

## Purpose

This document establishes engineering standards for the DscienTia platform.

The goal is to ensure:

* Consistent implementation
* Maintainable code
* Scalable architecture
* High-quality software delivery

These standards apply to:

* Flutter applications
* Laravel services
* PostgreSQL databases
* IBM watsonx integrations

---

# Engineering Principles

All development activities should follow these principles.

## Simplicity First

Prefer simple solutions over complex solutions.

Avoid introducing complexity unless there is a clear business or technical justification.

---

## Readability Over Cleverness

Code should be understandable by other developers.

Prioritize:

* Clarity
* Consistency
* Maintainability

over clever implementation techniques.

---

## Modular Design

Features should remain independent whenever possible.

Avoid tightly coupled implementations.

---

## Reusability

Reusable functionality should be extracted into shared components.

Avoid unnecessary duplication.

---

## Security by Design

Security should be considered from the beginning of implementation.

It must not be treated as an afterthought.

---

## AI-Ready Architecture

Systems should be designed to support:

* AI integrations
* Future intelligence services
* Model replacement

without major architectural changes.

---

# Architecture Standards

## Clean Architecture

Flutter modules should follow:

```text id="ca1"
presentation
application
domain
data
```

Responsibilities must remain clearly separated.

---

## Feature-Based Organization

New functionality should be added inside existing features whenever possible.

Example:

```text id="ca2"
features/reports/
features/projects/
features/insights/
```

Avoid organizing code by technical layer at the root level.

---

## Dependency Direction

Dependencies must flow inward.

Example:

```text id="ca3"
Presentation
↓
Application
↓
Domain
↓
Data
```

The reverse is not allowed.

---

# Flutter Standards

## State Management

Official state management:

```text id="f1"
Riverpod
```

All new stateful functionality should use Riverpod.

Avoid introducing additional state management frameworks.

---

## Navigation

Official navigation solution:

```text id="f2"
GoRouter
```

Navigation logic should remain centralized.

---

## Widget Design

Prefer:

```text id="f3"
Small Widgets
Composable Widgets
Reusable Widgets
```

Avoid excessively large screens.

---

## Screen Structure

Recommended:

```text id="f4"
screen.dart
widgets/
providers/
models/
```

---

## UI Principles

Every screen should support:

* Loading state
* Empty state
* Error state
* Success state

---

## Responsive Design

UI should adapt to:

* Mobile phones
* Tablets

Future desktop support should remain possible.

---

# Laravel Standards

## Controller Responsibilities

Controllers should remain thin.

Controllers should:

* Receive requests
* Validate requests
* Call services
* Return responses

Business logic must not reside inside controllers.

---

## Service Layer

Business logic belongs inside services.

Example:

```text id="l1"
ProjectService
ReportService
InsightService
```

---

## Repository Layer

Database access should be abstracted through repositories.

Avoid direct database queries throughout the application.

---

## Validation

All API input must be validated.

Validation should occur before business logic execution.

---

## API Responses

Responses should remain consistent.

Recommended structure:

```json
{
  "success": true,
  "message": "Operation completed",
  "data": {}
}
```

Error example:

```json
{
  "success": false,
  "message": "Validation failed",
  "errors": {}
}
```

---

# Database Standards

## Naming Convention

Tables:

```text id="db1"
snake_case
plural
```

Examples:

```text id="db2"
users
projects
reports
ai_insights
risk_assessments
recommendations
```

---

## Primary Keys

Use:

```text id="db3"
id
```

as the primary key field.

---

## Timestamps

All tables should include:

```text id="db4"
created_at
updated_at
```

Soft delete support should be added when appropriate.

---

## Foreign Keys

All relationships should use foreign key constraints.

Referential integrity must be maintained.

---

# API Standards

## REST First

All services should be exposed through REST APIs.

---

## Resource Naming

Examples:

```text id="api1"
GET /projects
GET /reports
GET /insights
```

Avoid verbs in endpoint names.

---

## Versioning

API versioning should be explicit.

Example:

```text id="api2"
api/v1/
```

---

## Status Codes

Use standard HTTP status codes.

Examples:

```text id="api3"
200 OK
201 Created
400 Bad Request
401 Unauthorized
403 Forbidden
404 Not Found
500 Internal Server Error
```

---

# AI Integration Standards

## AI as a Service

AI functionality should remain isolated.

Recommended:

```text id="ai1"
WatsonxService
InsightGenerator
RiskAnalyzer
RecommendationEngine
```

---

## Prompt Management

Prompts should not be embedded directly in controllers.

Store prompts in:

```text id="ai2"
resources/prompts/
```

---

## Output Validation

AI-generated responses should be validated before persistence.

Never trust model outputs blindly.

---

## Explainability

AI outputs should include:

```text id="ai3"
summary
confidence_score
supporting_evidence
```

whenever possible.

---

# Logging Standards

## Log Important Events

Examples:

* Authentication events
* Report submission
* AI execution
* Failed requests

---

## Avoid Sensitive Data

Logs must never contain:

* Passwords
* Tokens
* Secrets
* Personal identifiers

---

# Error Handling Standards

## Fail Gracefully

Applications should provide meaningful error messages.

Avoid exposing internal implementation details.

---

## User-Friendly Messages

Prefer:

```text id="err1"
Unable to generate insight.
Please try again.
```

Instead of:

```text id="err2"
NullReferenceException at line 213.
```

---

# Documentation Standards

## Keep Documentation Current

Documentation should evolve together with implementation.

Major architectural changes must be reflected in documentation.

---

## Architecture First

Before implementing major functionality:

1. Update architecture
2. Update API specification
3. Update data models
4. Implement feature

---

# Testing Standards

## Backend

Minimum:

* Feature Tests
* API Tests

---

## Flutter

Minimum:

* Widget Tests
* State Management Tests

---

## AI Services

Validate:

* Response format
* Confidence score handling
* Error scenarios

---

# Performance Standards

## Mobile

Prioritize:

* Fast startup time
* Responsive UI
* Minimal unnecessary rebuilds

---

## Backend

Prioritize:

* Efficient database queries
* Proper indexing
* Pagination

---

# Code Review Checklist

Before merging:

* Architecture respected
* Naming conventions followed
* Tests updated
* Documentation updated
* Security reviewed
* API contracts maintained

---

# Related Documents

* Architecture v1
* Project Structure
* System Architecture
* API Specification v1
* Definition of Done

---

# Version

Engineering Standards v1

Created: June 2026

Project:

DscienTia — AI-Powered Community Impact Intelligence Platform
