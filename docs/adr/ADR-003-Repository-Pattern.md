# ADR-003 — Repository Pattern

| Field | Value |
|------|------|
| **Status** | ✅ Accepted |
| **Version** | 1.0 |
| **Date** | July 2026 |
| **Decision Owner** | Prio Nugroho |
| **Related Sprint** | FL-003 — Foundation Layer |
| **Scope** | Data Access Architecture |

---

# 1. Context

DscienTia Mobile interacts with multiple data sources throughout its lifecycle.

Current and planned data sources include:

- REST API
- Secure Storage
- Hive Local Database
- Shared Preferences
- Cached Responses
- Firebase Services
- AI APIs
- Future Offline Synchronization

Without a dedicated abstraction layer, presentation logic becomes tightly coupled to infrastructure.

For example:

- Widgets would perform HTTP requests.
- Providers would manage JSON parsing.
- Business logic would become dependent on networking libraries.

Such coupling reduces maintainability, complicates testing, and makes future infrastructure changes expensive.

The project therefore requires a dedicated abstraction responsible for coordinating all application data access.

---

# 2. Decision

DscienTia Mobile adopts the **Repository Pattern**.

Repositories become the only architectural layer responsible for accessing application data.

Repositories abstract away infrastructure details and expose business-oriented operations to the presentation layer.

Neither Widgets nor Providers communicate directly with:

- Dio
- Hive
- Firebase
- Secure Storage
- REST Endpoints
- Local Cache

Instead, all communication flows through repositories.

---

# 3. Architecture

Repository architecture:

```text
Widget

↓

Provider

↓

Repository

↓

Data Source

↓

API / Database
```

Future architecture:

```text
Repository

├── Remote Data Source

├── Local Data Source

├── Secure Storage

└── Cache
```

Each repository determines the appropriate source of truth.

---

# 4. Repository Responsibilities

Repositories are responsible for:

- retrieving application data;
- selecting the appropriate data source;
- coordinating remote and local storage;
- converting infrastructure exceptions;
- exposing business-oriented methods;
- returning domain entities or models.

Repositories should remain independent from Flutter Widgets.

---

# 5. Data Source Responsibilities

Data Sources have a single responsibility.

Examples include:

## Remote Data Source

Responsible for:

- HTTP requests
- API communication
- Response parsing

---

## Local Data Source

Responsible for:

- Hive
- Local persistence
- Offline cache

---

## Secure Storage

Responsible for:

- Tokens
- Credentials
- Sensitive configuration

Each Data Source should remain independent and reusable.

---

# 6. Provider Responsibilities

Providers coordinate repositories.

Providers should:

- request business operations;
- expose application state;
- notify UI changes.

Providers must never:

- perform HTTP requests;
- manipulate Dio;
- access databases directly;
- parse JSON.

---

# 7. Widget Responsibilities

Widgets remain presentation-only.

Widgets should:

- display data;
- receive user interaction;
- observe Providers.

Widgets must never:

- access repositories directly;
- perform networking;
- manipulate storage;
- contain business logic.

---

# 8. Benefits

## Separation of Concerns

Business logic remains independent from infrastructure.

---

## Testability

Repositories can be mocked independently during unit testing.

---

## Flexibility

Infrastructure can change without affecting presentation.

For example:

```text
REST API

↓

GraphQL
```

No Widget changes should be required.

---

## Offline Support

Repositories naturally support future offline synchronization.

---

## Scalability

Additional data sources can be introduced without architectural changes.

---

# 9. Consequences

## Positive

- Better maintainability
- Cleaner business logic
- Easier testing
- Infrastructure independence
- Reduced coupling
- Future-proof architecture

---

## Negative

- Additional abstraction layer
- More project files
- Requires disciplined implementation

The advantages outweigh the additional complexity.

---

# 10. Alternatives Considered

## Direct Dio Usage

Advantages

- Simple
- Fast implementation

Disadvantages

- Tight coupling
- Difficult testing
- Poor maintainability

Decision

❌ Rejected

---

## Provider → API

Advantages

- Fewer classes

Disadvantages

- Business logic mixed with networking
- Violates Separation of Concerns

Decision

❌ Rejected

---

## Service-only Architecture

Advantages

- Smaller abstraction

Disadvantages

- Repository responsibilities become unclear
- Harder to support multiple data sources

Decision

❌ Rejected

---

## Repository Pattern

Advantages

- Infrastructure abstraction
- Clean Architecture compatibility
- Excellent scalability
- Better testing support

Decision

✅ Accepted

---

# 11. Architectural Rules

The following rules are mandatory.

## Rule 1

Every feature owns its own Repository.

Example:

```text
features/

authentication/

data/

repository/
```

---

## Rule 2

Repository implementations belong inside:

```text
data/repository/
```

Repository contracts belong inside:

```text
domain/repositories/
```

---

## Rule 3

Repositories expose business operations.

Example:

```text
Future<User> login()

Future<User> profile()

Future<void> logout()
```

instead of low-level HTTP operations.

---

## Rule 4

Repositories communicate with Data Sources.

Providers communicate with Repositories.

Widgets communicate with Providers.

---

## Rule 5

Repositories must never depend on Flutter Widgets.

---

## Rule 6

Networking libraries remain isolated inside the Data Layer.

---

# 12. Future Considerations

Repository implementations may later coordinate:

- Offline synchronization
- Background refresh
- Retry strategies
- AI inference
- Local cache invalidation
- Multi-source synchronization

These future capabilities should not require changes to the presentation layer.

---

# 13. Relationship with Other ADRs

This ADR defines how application data is accessed.

Related architectural decisions include:

- ADR-001 defines project organization.
- ADR-002 defines application state management.
- ADR-004 defines application startup lifecycle.

---

# 14. References

## Internal Documentation

- [Flutter Architecture](../flutter/Flutter-Architecture.md)
- [Repository Pattern](../flutter/Repository-Pattern.md)
- [Networking](../flutter/Networking.md)
- [Provider Pattern](../flutter/Provider-Pattern.md)
- [State Management](../flutter/State-Management.md)

---

## Architecture Decision Records

- [ADR-000 — Architecture Decision Record Guidelines](ADR-000-ADR-Guidelines.md)
- [ADR-001 — Feature-first Architecture](ADR-001-Feature-First-Architecture.md)
- [ADR-002 — Riverpod State Management](ADR-002-Riverpod-State-Management.md)

---

## Architecture Reviews

- [Flutter Architecture Baseline v1.0](../reviews/flutter/Flutter-Architecture-Baseline-v1.0.md)

---

## External References

- Martin Fowler — Repository Pattern
- Robert C. Martin — Clean Architecture
- Flutter Documentation — https://docs.flutter.dev/
- Riverpod Documentation — https://riverpod.dev/