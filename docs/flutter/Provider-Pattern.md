# Provider Pattern

**Version:** v0.8 Foundation Architecture

**Status:** Official Standard

---

# Purpose

This document defines the official Provider Pattern used throughout the DscienTia Flutter application.

Riverpod Providers act as the bridge between the presentation layer and the repository layer.

Providers expose application state to the UI while delegating all business operations to repositories.

---

# Objectives

The Provider Pattern is designed to:

* Separate UI from business logic.
* Centralize state management.
* Improve testability.
* Standardize asynchronous operations.
* Simplify feature development.
* Ensure consistent AI-generated implementations.

---

# Responsibilities

Providers are responsible for:

* Managing UI state.
* Calling repositories.
* Handling loading state.
* Handling success state.
* Handling failure state.
* Exposing immutable state to the UI.

Providers are **not** responsible for:

* API communication.
* Database access.
* Data serialization.
* Navigation.
* Widget rendering.

---

# Architecture Position

```text
Presentation (Screen)

↓

Riverpod Provider

↓

Repository

↓

Datasource
```

Providers never communicate directly with:

* Dio
* Hive
* SQLite
* Secure Storage

---

# Provider Lifecycle

Every feature follows the same lifecycle.

```text
User Action

↓

Provider

↓

Repository

↓

Datasource

↓

Repository Result

↓

Provider State

↓

UI Refresh
```

---

# Provider Structure

Each feature owns its own providers.

Example

```text
features/

authentication/

providers/

authentication_provider.dart
```

Another example

```text
features/

reports/

providers/

reports_provider.dart
```

Providers must remain isolated within their feature.

---

# Provider Responsibilities

Providers should:

* Trigger repository operations.
* Update application state.
* Notify listeners.
* Expose immutable state.
* Handle loading indicators.
* Handle user-facing errors.

Providers should never:

* Parse JSON.
* Call Dio.
* Execute SQL.
* Instantiate repositories manually.
* Contain widget logic.

---

# State Flow

The official state flow is:

```text
Initial

↓

Loading

↓

Success

or

Failure
```

Every asynchronous operation should follow this lifecycle.

---

# Dependency Rules

Allowed

```text
Screen

↓

Provider

↓

Repository
```

Forbidden

```text
Screen

↓

Repository
```

Forbidden

```text
Screen

↓

Dio
```

Forbidden

```text
Widget

↓

API
```

---

# Provider Types

The project primarily uses:

* Provider
* StateProvider
* FutureProvider
* AsyncNotifierProvider
* NotifierProvider

Selection depends on feature complexity and lifecycle requirements.

---

# Error Handling

Providers receive standardized failures from repositories.

Providers convert failures into user-friendly application states.

Providers should never expose raw exceptions.

---

# Testing

Providers must be independently testable.

Repository dependencies should be mocked during testing.

Widget rendering should not be required to validate provider behavior.

---

# Engineering Rules

Every provider must:

* Have a single responsibility.
* Represent one feature.
* Use dependency injection.
* Delegate business logic to repositories.
* Expose immutable state.
* Remain UI independent.

---

# Relationship with Other Documents

This document should be read together with:

* Flutter-Architecture.md
* Repository-Pattern.md
* State-Management.md
* Error-Handling.md

Together these documents define the official state management architecture for the DscienTia Flutter application.
