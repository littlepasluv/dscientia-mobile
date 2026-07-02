# Repository Pattern

**Version:** v0.8 Foundation Architecture

**Status:** Official Standard

---

# Purpose

This document defines the official Repository Pattern used throughout the DscienTia Flutter application.

The Repository Pattern acts as the single gateway between the presentation layer and every data source.

Repositories isolate business logic from networking, storage, and infrastructure concerns.

---

# Objectives

The Repository Pattern exists to:

* Separate UI from data access.
* Centralize business data flow.
* Simplify testing.
* Support multiple data sources.
* Improve maintainability.
* Enable offline-first capability.
* Standardize AI-generated code.

---

# Responsibilities

Repositories are responsible for:

* Retrieving data.
* Saving data.
* Updating data.
* Deleting data.
* Selecting the appropriate data source.
* Mapping DTOs into domain models.
* Returning standardized results.

Repositories are **not** responsible for:

* Rendering UI.
* Navigation.
* Widget state.
* Screen lifecycle.

---

# Architecture Position

```text
Presentation
      │
Riverpod Provider
      │
Repository
      │
Datasource
 ┌──────────────┐
 │              │
Remote API   Local Storage
```

Providers communicate only with repositories.

Repositories communicate only with data sources.

---

# Repository Lifecycle

Every feature follows the same flow.

```text
Screen

↓

Provider

↓

Repository

↓

Datasource

↓

Network / Database
```

---

# Standard Repository Structure

Each feature owns its own repository.

Example

```text
features/

authentication/

repository/

authentication_repository.dart
```

Another example

```text
features/

reports/

repository/

reports_repository.dart
```

Repositories must never be shared between unrelated features.

---

# Repository Responsibilities

A repository may:

* Call multiple APIs.
* Merge responses.
* Read local cache.
* Write local cache.
* Perform data mapping.
* Handle synchronization.

Repositories should remain unaware of UI implementation.

---

# Data Sources

Repositories may communicate with multiple data sources.

Example

```text
Repository

↓

REST API

↓

Secure Storage

↓

Hive

↓

SQLite
```

The presentation layer never communicates directly with any of these components.

---

# Error Handling

Repositories never expose raw exceptions.

Instead, repositories return standardized failures.

Example

```text
Repository

↓

Failure

↓

Provider

↓

UI
```

The UI should never display stack traces or exception messages.

---

# Repository Rules

Every repository must:

* Have a single responsibility.
* Represent one business capability.
* Be independently testable.
* Never depend on widgets.
* Never depend on BuildContext.
* Never perform navigation.

---

# Dependency Rules

Allowed

```text
Provider

↓

Repository

↓

Datasource
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

API Service
```

Forbidden

```text
Widget

↓

Dio
```

---

# Future Ready

The Repository Pattern is intentionally designed to support:

* Offline-first synchronization.
* Background synchronization.
* Multiple API providers.
* AI-generated content.
* Local caching.
* Enterprise-scale feature expansion.

No architectural changes should be required when these capabilities are introduced.

---

# Relationship with Other Documents

This document should be read together with:

* Flutter-Architecture.md
* Provider-Pattern.md
* Networking.md
* State-Management.md
* Error-Handling.md

Together these documents define the engineering standard for every Flutter feature developed within the DscienTia project.
