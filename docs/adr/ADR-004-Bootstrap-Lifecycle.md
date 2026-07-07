# ADR-004 — Bootstrap Lifecycle

| Field | Value |
|------|------|
| **Status** | ✅ Accepted |
| **Version** | 1.0 |
| **Date** | July 2026 |
| **Decision Owner** | Prio Nugroho |
| **Related Sprint** | FL-003 — Foundation Layer |
| **Scope** | Application Initialization |

---

# 1. Context

Every Flutter application begins execution from `main()`.

While suitable for small applications, placing all initialization logic directly inside `main()` creates several long-term problems.

As DscienTia Mobile evolves, application startup will require initialization of multiple infrastructure components, including:

- Environment configuration
- Dependency Injection
- Networking
- Local Database
- Secure Storage
- Firebase
- Remote Configuration
- Crash Reporting
- Analytics
- AI Services
- Offline Synchronization

Embedding this logic directly inside `main()` would make the application's entry point increasingly difficult to understand, maintain, and test.

The project therefore requires a dedicated application bootstrap process.

---

# 2. Decision

DscienTia Mobile adopts a dedicated **Bootstrap Layer**.

The Bootstrap Layer becomes responsible for orchestrating the complete application startup lifecycle before the UI is rendered.

The `main()` function should remain minimal and delegate initialization to the Bootstrap layer.

Example:

```dart
Future<void> main() async {
  await AppBootstrap.initialize();
}
```

This approach centralizes all startup responsibilities into a single, maintainable component.

---

# 3. Architecture

Application startup flow:

```text
main()

↓

WidgetsFlutterBinding.ensureInitialized()

↓

AppBootstrap.initialize()

↓

Initialize Configuration

↓

Initialize Infrastructure

↓

ProviderScope

↓

DscientiaApp

↓

MaterialApp.router
```

Future startup flow:

```text
main()

↓

Bootstrap

├── Environment
├── Logger
├── Dio
├── Hive
├── Secure Storage
├── Firebase
├── Remote Config
├── Crashlytics
├── Analytics
├── AI Services
└── Dependency Injection

↓

runApp()
```

---

# 4. Bootstrap Responsibilities

The Bootstrap layer is responsible for:

- application initialization
- infrastructure startup
- dependency registration
- configuration loading
- startup orchestration
- application lifecycle preparation

Bootstrap should remain independent from business features.

---

# 5. Main Function Responsibilities

The `main()` function should:

- initialize Flutter bindings
- invoke the Bootstrap layer

The `main()` function must not:

- configure networking
- initialize Firebase
- initialize databases
- perform authentication
- configure routing
- contain business logic

Its sole purpose is to delegate startup responsibilities.

---

# 6. Configuration Responsibilities

Configuration initialization includes:

- application environment
- API configuration
- global providers
- routing
- application theme

Configuration belongs inside the `config/` layer and is coordinated by Bootstrap.

---

# 7. Benefits

## Separation of Concerns

Startup logic is isolated from application logic.

---

## Maintainability

Future infrastructure additions require modifications only within the Bootstrap layer.

---

## Scalability

Additional services can be introduced without increasing the complexity of `main()`.

---

## Testability

Bootstrap initialization can be tested independently from the user interface.

---

## Consistency

All application startup follows a single, predictable workflow.

---

# 8. Consequences

## Positive

- Cleaner application entry point
- Centralized startup process
- Improved readability
- Easier infrastructure integration
- Better long-term maintainability

---

## Negative

- One additional architectural layer
- Slightly more project structure

The long-term benefits outweigh the additional abstraction.

---

# 9. Alternatives Considered

## Large main()

Advantages

- Simple for small projects

Disadvantages

- Difficult to maintain
- Startup logic becomes scattered
- Poor scalability

Decision

❌ Rejected

---

## Service Locator Initialization

Advantages

- Centralized services

Disadvantages

- Does not clearly define application startup order

Decision

❌ Rejected

---

## Bootstrap Layer

Advantages

- Explicit startup lifecycle
- Clear orchestration
- Easy future extension
- Compatible with Clean Architecture

Decision

✅ Accepted

---

# 10. Architectural Rules

The following rules are mandatory.

## Rule 1

All application startup must occur through the Bootstrap layer.

---

## Rule 2

The `main()` function should remain minimal.

---

## Rule 3

Business features must never perform application initialization.

---

## Rule 4

Infrastructure services should be initialized before `runApp()`.

---

## Rule 5

Bootstrap should never contain business logic.

---

## Rule 6

The Bootstrap layer coordinates initialization but does not own application state.

---

# 11. Future Considerations

Future versions of the Bootstrap layer may initialize:

- Hive
- Secure Storage
- Firebase Authentication
- Firebase Analytics
- Firebase Crashlytics
- Remote Config
- Push Notifications
- AI Services
- Offline Synchronization
- Dependency Graph Validation

The Bootstrap layer provides a single extension point for future infrastructure growth.

---

# 12. Relationship with Other ADRs

This ADR defines how the application is initialized.

Related architectural decisions include:

- ADR-001 defines overall project organization.
- ADR-002 defines state management.
- ADR-003 defines data access.

Together, these ADRs establish the architectural foundation of DscienTia Mobile.

---

# 13. References

## Internal Documentation

- [Flutter Architecture](../flutter/Flutter-Architecture.md)
- [Routing](../flutter/Routing.md)
- [Networking](../flutter/Networking.md)
- [Theming](../flutter/Theming.md)

---

## Architecture Decision Records

- [ADR-000 — Architecture Decision Record Guidelines](ADR-000-ADR-Guidelines.md)
- [ADR-001 — Feature-first Architecture](ADR-001-Feature-First-Architecture.md)
- [ADR-002 — Riverpod State Management](ADR-002-Riverpod-State-Management.md)
- [ADR-003 — Repository Pattern](ADR-003-Repository-Pattern.md)

---

## Architecture Reviews

- [Flutter Architecture Baseline v1.0](../reviews/flutter/Flutter-Architecture-Baseline-v1.0.md)

---

## External References

- Flutter Documentation — https://docs.flutter.dev/
- Robert C. Martin — Clean Architecture
- Martin Fowler — Application Architecture Patterns