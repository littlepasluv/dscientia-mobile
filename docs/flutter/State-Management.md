# State Management

**Project:** DscienTia Mobile Application

**Version:** v0.8 Foundation Architecture

**Status:** Official Standard

---

# Purpose

This document defines the official state management architecture used throughout the DscienTia Flutter application.

The application adopts **Riverpod 3.x** as the single state management solution.

All application state must be managed through Riverpod providers.

---

# Objectives

The state management architecture is designed to:

* Centralize application state.
* Separate UI from business logic.
* Improve scalability.
* Simplify testing.
* Reduce widget complexity.
* Standardize AI-generated implementations.

---

# Design Principles

The application follows these principles:

* Single source of truth.
* Immutable state.
* Predictable state transitions.
* Business logic outside widgets.
* Providers communicate with repositories.
* Screens consume provider state only.

---

# Architecture Position

```text
Screen

↓

Provider

↓

Repository

↓

Datasource
```

Providers represent the application's state layer.

---

# State Flow

Every feature follows the same lifecycle.

```text
Initial

↓

Loading

↓

Success

or

Failure
```

State transitions should always be explicit.

---

# Provider Hierarchy

The application primarily uses the following provider types.

## Provider

Used for immutable shared dependencies.

Examples:

* Repository
* Configuration
* API Client

---

## StateProvider

Used for simple mutable UI state.

Examples:

* Selected tab
* Theme mode
* Search keyword
* Filter selection

Business logic should not be placed inside StateProvider.

---

## FutureProvider

Used for one-time asynchronous operations.

Examples:

* Loading static configuration.
* Initial application settings.

---

## NotifierProvider

Used for synchronous business state.

Examples:

* Form validation.
* UI interaction state.
* Local feature state.

---

## AsyncNotifierProvider

Preferred for asynchronous business operations.

Examples:

* Authentication.
* AI Insight.
* Reports.
* Dashboard.
* Risk Assessment.

This provider type should be the default choice for feature-level asynchronous workflows.

---

# State Ownership

Each feature owns its own state.

Example

```text
features/

authentication/

providers/
```

Another example

```text
features/

reports/

providers/
```

Features should never directly manipulate another feature's provider state.

---

# State Responsibilities

Providers are responsible for:

* Managing state.
* Triggering repositories.
* Updating UI state.
* Exposing immutable values.

Providers are not responsible for:

* HTTP requests.
* Database access.
* Navigation.
* Widget rendering.

---

# UI Responsibilities

Screens observe providers.

Screens should:

* Display state.
* Trigger provider actions.
* Render loading.
* Render success.
* Render failure.

Screens should never store business state locally.

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
Widget

↓

Datasource
```

Forbidden

```text
Screen

↓

Dio
```

---

# State Immutability

Application state should remain immutable.

State updates should create new state objects rather than modifying existing instances.

This improves:

* predictability
* debugging
* testing
* maintainability

---

# Error State

Failures returned by repositories become application state.

Example

```text
Loading

↓

Failure

↓

Retry
```

Providers should never expose raw exceptions.

---

# Testing

Providers should be independently testable.

Repository dependencies should be mocked.

Widget rendering should not be required to verify business state transitions.

---

# Future Expansion

The architecture supports:

* Offline-first mode.
* Background synchronization.
* State persistence.
* AI-generated workflows.
* Real-time synchronization.
* Feature modularization.

No architectural changes should be required as the application grows.

---

# Engineering Rules

Every provider must:

* Have one responsibility.
* Own one feature state.
* Delegate business logic to repositories.
* Expose immutable state.
* Remain independently testable.

---

# Relationship with Other Documents

This document should be read together with:

* Flutter-Architecture.md
* Provider-Pattern.md
* Repository-Pattern.md
* Error-Handling.md
* Networking.md

Together these documents define the official state management architecture for the DscienTia Flutter application.
