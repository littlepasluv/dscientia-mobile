# ADR-001 — Feature-first Architecture

| Field | Value |
|------|------|
| **Status** | ✅ Accepted |
| **Version** | 1.0 |
| **Date** | July 2026 |
| **Decision Owner** | Prio Nugroho |
| **Related Sprint** | FL-003 — Foundation Layer |
| **Scope** | Application Architecture |

---

# 1. Context

DscienTia Mobile is designed as a long-term software platform rather than a single-purpose application.

The project roadmap includes multiple independent business domains, including:

- Authentication
- Dashboard
- Reports
- Recommendations
- AI Insight
- Risk Assessment
- Profile
- Settings

Additional modules such as Notifications, Payments, Chat, Offline Synchronization, and Web3 integrations may also be introduced in future releases.

As the application grows, organizing source code solely by technical layer (such as screens, providers, or repositories) increases coupling between unrelated business domains and makes maintenance progressively more difficult.

The project therefore required an architectural approach capable of supporting long-term scalability while maintaining clear ownership of business functionality.

---

# 2. Decision

DscienTia Mobile adopts a **Feature-first Architecture**.

Each business capability owns its complete implementation, including:

- presentation
- domain
- data

instead of separating files globally by technical concern.

Every feature becomes an independent module responsible for its own business logic.

Example:

```text
features/

authentication/
    data/
    domain/
    presentation/

reports/
    data/
    domain/
    presentation/

ai_insight/
    data/
    domain/
    presentation/
```

Infrastructure shared by multiple features is extracted into dedicated architectural layers:

```text
config/
```

Application configuration.

```text
core/
```

Reusable infrastructure.

```text
shared/
```

Reusable UI components and abstractions.

```text
bootstrap/
```

Application startup lifecycle.

---

# 3. Architecture

High-level architecture:

```text
                    app
                     │
                     ▼
                bootstrap
                     │
                     ▼
                  config
                     │
                     ▼
                 features
                ↙         ↘
           shared        core
```

Feature structure:

```text
feature/

data/

domain/

presentation/
```

Each feature owns its implementation while remaining isolated from other business modules.

---

# 4. Benefits

The Feature-first approach provides several advantages.

## Scalability

New business capabilities can be introduced without affecting unrelated features.

---

## Maintainability

Business logic remains localized within each feature.

Developers can navigate the project according to business functionality rather than technical implementation.

---

## Team Collaboration

Multiple developers can work on separate features with minimal merge conflicts.

---

## Better Separation of Concerns

Presentation, business logic, and data remain organized within the same business domain.

---

## Easier Testing

Each feature can be tested independently.

---

## Future Modularization

The architecture allows future extraction into independent packages if required.

---

# 5. Consequences

## Positive

- Excellent scalability
- Clear ownership
- Easier maintenance
- Reduced coupling
- Better onboarding
- Improved readability

---

## Negative

- Larger folder hierarchy
- More architectural discipline required
- Slightly higher learning curve for new contributors

These trade-offs are considered acceptable given the expected lifetime of the project.

---

# 6. Alternatives Considered

## Layer-first Architecture

Example:

```text
screens/
providers/
repositories/
models/
```

### Advantages

- Simple
- Familiar
- Suitable for small applications

### Disadvantages

- Business logic becomes fragmented
- Difficult navigation
- High coupling
- Poor scalability

Decision:

❌ Rejected

---

## Package-by-Layer

Grouping by technical implementation.

Decision:

❌ Rejected

Reason:

Business ownership becomes unclear.

---

## Feature-first Architecture

Decision:

✅ Accepted

Reason:

Provides the best balance between scalability, maintainability, readability, and modularity.

---

# 7. Architectural Rules

The following rules are mandatory.

## Rule 1

Every business capability must be implemented as a Feature.

---

## Rule 2

Features own:

- presentation
- domain
- data

---

## Rule 3

No feature should directly access another feature's internal implementation.

Cross-feature communication must occur through shared abstractions or repositories.

---

## Rule 4

Reusable UI belongs inside:

```text
shared/
```

---

## Rule 5

Infrastructure belongs inside:

```text
core/
```

---

## Rule 6

Application configuration belongs inside:

```text
config/
```

---

## Rule 7

Startup logic belongs inside:

```text
bootstrap/
```

---

# 8. Future Considerations

As DscienTia Mobile evolves, new features should continue following the Feature-first approach.

Examples include:

```text
notifications/

payments/

chat/

analytics/

web3/

offline_sync/
```

If future scaling requires package separation, Feature-first Architecture provides a natural migration path.

---

# 9. Relationship with Other ADRs

This ADR establishes the overall project organization.

Subsequent ADRs refine implementation details.

- ADR-002 defines how application state is managed.
- ADR-003 defines how data access is organized.
- ADR-004 defines how the application startup lifecycle is orchestrated.

---

# 10. References

## Internal Documentation

- [Flutter Architecture](../flutter/Flutter-Architecture.md)
- [Folder Structure](../flutter/Folder-Structure.md)
- [Repository Pattern](../flutter/Repository-Pattern.md)
- [Provider Pattern](../flutter/Provider-Pattern.md)

---

## Architecture Decision Records

- [ADR-000 — Architecture Decision Record Guidelines](ADR-000-ADR-Guidelines.md)

---

## Architecture Reviews

- [Flutter Architecture Baseline v1.0](../reviews/flutter/Flutter-Architecture-Baseline-v1.0.md)

---

## External References

- Flutter Documentation — https://docs.flutter.dev/
- Robert C. Martin — Clean Architecture
- Martin Fowler — Patterns of Enterprise Application Architecture
- Michael Nygard — Documenting Architecture Decisions