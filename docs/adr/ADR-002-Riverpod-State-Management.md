# ADR-002 — Riverpod State Management

| Field | Value |
|------|------|
| **Status** | ✅ Accepted |
| **Version** | 1.0 |
| **Date** | July 2026 |
| **Decision Owner** | Prio Nugroho |
| **Related Sprint** | FL-003 — Foundation Layer |
| **Scope** | Application State Management |

---

# 1. Context

DscienTia Mobile is expected to become a feature-rich application with multiple independent business domains.

Examples include:

- Authentication
- Dashboard
- Reports
- Recommendations
- AI Insight
- Risk Assessment
- Settings

Each feature requires its own application state while remaining isolated from unrelated modules.

As the application grows, the project requires a state management solution that supports:

- scalability
- maintainability
- dependency injection
- testability
- compile-time safety
- predictable state updates

Several Flutter state management solutions were evaluated before selecting the official architecture.

---

# 2. Decision

DscienTia Mobile adopts **Riverpod** as the official state management framework.

Riverpod is responsible for:

- application state
- dependency injection
- provider lifecycle
- repository injection
- configuration injection

Riverpod becomes the single source of truth for dependency resolution across the application.

Widgets never instantiate repositories or services directly.

Instead, dependencies are obtained through Providers.

---

# 3. Architecture

State management flow:

```text
Widget

↓

Provider

↓

Repository

↓

Data Source

↓

API / Local Storage
```

Dependency Injection flow:

```text
App

↓

ProviderScope

↓

Riverpod

↓

Repository

↓

Service

↓

API
```

Each layer has a single responsibility.

---

# 4. Provider Responsibilities

Providers are responsible for:

- exposing application state
- coordinating repositories
- managing asynchronous operations
- notifying UI updates
- dependency injection

Providers should remain lightweight.

Business rules should be delegated to repositories or domain services.

---

# 5. Widget Responsibilities

Widgets are responsible only for presentation.

Widgets should:

- display UI
- receive user interaction
- observe Providers

Widgets must never:

- perform networking
- manipulate Dio
- access databases
- contain business rules
- instantiate repositories

---

# 6. Repository Responsibilities

Repositories own business-oriented data access.

Repositories:

- communicate with data sources
- determine where data originates
- convert infrastructure errors
- return domain models

Repositories should not know anything about Flutter Widgets.

---

# 7. Benefits

## Scalability

Every feature owns its own Providers without affecting unrelated modules.

---

## Predictable State

Riverpod provides deterministic dependency resolution.

---

## Dependency Injection

Application dependencies are centralized and explicit.

---

## Testability

Providers and repositories can be mocked independently.

---

## Performance

Riverpod minimizes unnecessary widget rebuilds.

---

## Maintainability

Presentation remains isolated from infrastructure.

---

# 8. Consequences

## Positive

- Excellent scalability
- Explicit dependency graph
- Improved testability
- Compile-time safety
- Better separation of concerns
- Reduced global state

---

## Negative

- Learning curve for new contributors
- Additional Provider definitions
- Requires architectural discipline

These trade-offs are acceptable for a long-lived application.

---

# 9. Alternatives Considered

## Provider

Advantages:

- Simple
- Official Flutter ecosystem package

Disadvantages:

- Context-based dependency lookup
- Harder to scale
- Less explicit dependency graph

Decision:

❌ Rejected

---

## Bloc / Cubit

Advantages:

- Excellent event-driven architecture
- Mature ecosystem

Disadvantages:

- Additional boilerplate
- Higher complexity than required

Decision:

❌ Rejected

---

## GetX

Advantages:

- Minimal boilerplate
- Rapid development

Disadvantages:

- Heavy reliance on global state
- Less explicit dependency management

Decision:

❌ Rejected

---

## Redux

Advantages:

- Predictable state

Disadvantages:

- Excessive complexity for project scope

Decision:

❌ Rejected

---

## Riverpod

Advantages:

- Compile-time safety
- Explicit dependency graph
- Excellent testing support
- Native dependency injection
- Active ecosystem

Decision:

✅ Accepted

---

# 10. Architectural Rules

The following rules are mandatory.

## Rule 1

Every feature owns its own Providers.

Example:

```text
authentication/

presentation/

providers/
```

---

## Rule 2

Widgets must never instantiate repositories.

---

## Rule 3

Providers coordinate repositories.

---

## Rule 4

Repositories perform data access.

---

## Rule 5

Networking belongs inside repositories or data sources.

---

## Rule 6

Global application dependencies should be exposed through Riverpod Providers.

---

## Rule 7

Business logic must never be implemented directly inside Widgets.

---

# 11. Future Considerations

Future Riverpod integrations may include:

- Offline synchronization
- Local caching
- Authentication session management
- Background refresh
- Feature flags
- Remote configuration
- AI service orchestration

Riverpod provides sufficient flexibility to support these future capabilities.

---

# 12. Relationship with Other ADRs

This ADR defines how application state is managed.

Related decisions include:

- ADR-001 defines project organization.
- ADR-003 defines data access.
- ADR-004 defines application startup.

---

# 13. References

## Internal Documentation

- [Flutter Architecture](../flutter/Flutter-Architecture.md)
- [Provider Pattern](../flutter/Provider-Pattern.md)
- [State Management](../flutter/State-Management.md)
- [Repository Pattern](../flutter/Repository-Pattern.md)

---

## Architecture Decision Records

- [ADR-000 — Architecture Decision Record Guidelines](ADR-000-ADR-Guidelines.md)
- [ADR-001 — Feature-first Architecture](ADR-001-Feature-First-Architecture.md)

---

## Architecture Reviews

- [Flutter Architecture Baseline v1.0](../reviews/flutter/Flutter-Architecture-Baseline-v1.0.md)

---

## External References

- Flutter Documentation — https://docs.flutter.dev/
- Riverpod Documentation — https://riverpod.dev/
- Flutter Riverpod GitHub — https://github.com/rrousselGit/riverpod
- Robert C. Martin — Clean Architecture
- Martin Fowler — Patterns of Enterprise Application Architecture