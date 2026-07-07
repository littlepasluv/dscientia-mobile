# Authentication Module Architecture

| Field | Value |
|------|------|
| **Module** | Authentication |
| **Document** | Architecture |
| **Version** | 1.0 |
| **Status** | Planned |
| **Owner** | DscienTia Mobile Team |
| **Related Sprint** | FL-004 |

---

# 1. Purpose

This document defines the architectural design of the Authentication Module.

It describes:

- architectural boundaries;
- layer responsibilities;
- dependency direction;
- data flow;
- communication between components.

The Authentication Module follows the project's **Feature-first** and **Clean Architecture** principles.

---

# 2. Architectural Principles

The module follows the same principles established by the Flutter Foundation.

- Feature-first Architecture
- Clean Architecture
- Repository Pattern
- Riverpod State Management
- Dependency Inversion
- Separation of Concerns
- Single Responsibility Principle

No layer should violate these architectural boundaries.

---

# 3. High-Level Architecture

```text
Presentation Layer

↓

Riverpod Provider

↓

Repository

↓

Remote Data Source

↓

REST API
```

Only one dependency direction is allowed.

---

# 4. Feature Structure

```text
features/

authentication/

data/

datasource/

models/

repository/

domain/

entities/

repositories/

usecases/

presentation/

providers/

screens/

widgets/
```

Each folder has a single responsibility.

---

# 5. Layer Responsibilities

## Presentation Layer

Responsible for:

- Screens
- Widgets
- User interaction
- UI rendering

Presentation must never perform networking.

---

## Provider Layer

Responsible for:

- UI state
- Loading state
- Error state
- Calling Use Cases
- Notifying Widgets

Providers should remain free of business logic whenever possible.

---

## Domain Layer

Responsible for:

- Business rules
- Use Cases
- Repository contracts
- Domain entities

The Domain Layer must not depend on Flutter or infrastructure.

---

## Repository Layer

Responsible for:

- Abstracting data access
- Coordinating Data Sources
- Converting infrastructure models
- Returning domain objects

Repositories expose business operations rather than infrastructure operations.

---

## Data Source Layer

Responsible for:

- HTTP communication
- Request serialization
- Response parsing
- Error conversion

Each Data Source communicates with exactly one infrastructure service.

---

# 6. Dependency Direction

Allowed dependency flow:

```text
Presentation

↓

Provider

↓

Use Case

↓

Repository Contract

↓

Repository Implementation

↓

Remote Data Source

↓

REST API
```

Reverse dependencies are prohibited.

---

# 7. Authentication Flow

Successful login flow:

```text
User

↓

Login Screen

↓

Authentication Provider

↓

Login Use Case

↓

Authentication Repository

↓

Authentication Remote Data Source

↓

REST API

↓

JWT

↓

Repository

↓

Provider

↓

Dashboard
```

---

# 8. Folder Responsibilities

## data/

Infrastructure implementation.

Contains:

- DTOs
- Remote Data Sources
- Repository implementations

---

## domain/

Business logic.

Contains:

- Entities
- Repository contracts
- Use Cases

---

## presentation/

User interface.

Contains:

- Screens
- Widgets
- Providers

---

# 9. State Management

Authentication state is managed through Riverpod.

Expected states include:

```text
Unauthenticated

Loading

Authenticated

Refreshing

SessionExpired

Error
```

The Provider exposes immutable state to the presentation layer.

---

# 10. Error Handling

Authentication errors are propagated through the Repository.

Presentation should never receive raw Dio exceptions.

Instead, Providers expose user-friendly states.

Example:

```text
Invalid Credentials

↓

AuthenticationFailure.invalidCredentials
```

---

# 11. Security Boundary

Sensitive information must remain inside the data layer.

Examples:

- Access Token
- Refresh Token
- Session ID

Presentation must never manipulate authentication tokens directly.

---

# 12. Future Expansion

The architecture supports future additions without structural changes.

Examples:

- Biometric Login
- Google Authentication
- Apple Sign In
- Multi-factor Authentication
- Enterprise SSO
- Offline Login
- Token Rotation

---

# 13. Architectural Rules

The following rules are mandatory.

## Rule 1

Presentation communicates only with Providers.

---

## Rule 2

Providers communicate only with Use Cases or Repositories.

---

## Rule 3

Repositories communicate only with Data Sources.

---

## Rule 4

Data Sources communicate only with infrastructure services.

---

## Rule 5

No Flutter imports inside the Domain Layer.

---

## Rule 6

No Dio imports outside the Data Layer.

---

## Rule 7

No Widget accesses Secure Storage directly.

---

## Rule 8

Authentication state must be managed through Riverpod.

---

# 14. Relationship with Foundation Layer

This module follows decisions established during FL-003.

Related documentation:

- Flutter Architecture
- Repository Pattern
- Provider Pattern
- Networking
- State Management

Related ADRs:

- ADR-001 — Feature-first Architecture
- ADR-002 — Riverpod State Management
- ADR-003 — Repository Pattern
- ADR-004 — Bootstrap Lifecycle

---

# 15. References

## Feature Documentation

- README.md
- User-Flow.md
- API-Contract.md
- Repository.md
- Security.md
- Testing.md

---

## Flutter Documentation

- ../../flutter/Flutter-Architecture.md
- ../../flutter/Repository-Pattern.md
- ../../flutter/Provider-Pattern.md
- ../../flutter/Networking.md

---

## Architecture Decision Records

- ../../adr/ADR-001-Feature-First-Architecture.md
- ../../adr/ADR-002-Riverpod-State-Management.md
- ../../adr/ADR-003-Repository-Pattern.md
- ../../adr/ADR-004-Bootstrap-Lifecycle.md