# Screen Pattern

**Project:** DscienTia Mobile Application

**Version:** v0.8 Foundation Architecture

**Status:** Official Standard

---

# Purpose

This document defines the official Screen Pattern used throughout the DscienTia Flutter application.

Screens are responsible only for presenting information and handling user interaction.

Business logic must remain outside the presentation layer.

---

# Objectives

The Screen Pattern aims to:

* Maintain consistent UI architecture.
* Separate presentation from business logic.
* Improve maintainability.
* Simplify testing.
* Enable predictable AI-generated implementations.
* Keep widgets lightweight.

---

# Screen Responsibilities

Screens are responsible for:

* Displaying UI.
* Receiving user interaction.
* Reading Provider state.
* Triggering Provider actions.
* Rendering loading indicators.
* Rendering success states.
* Rendering failure states.

Screens are **not** responsible for:

* API communication.
* Business logic.
* Data parsing.
* Repository access.
* Local storage.
* Authentication logic.

---

# Architecture Position

```text
User

↓

Screen

↓

Riverpod Provider

↓

Repository

↓

Datasource
```

Screens communicate only with Providers.

---

# Standard Screen Structure

Every feature owns its own screens.

Example

```text
features/

authentication/

screens/

login_screen.dart

register_screen.dart

forgot_password_screen.dart
```

Another example

```text
features/

reports/

screens/

reports_screen.dart

report_detail_screen.dart
```

Screens should never be shared between unrelated features.

---

# Widget Hierarchy

The recommended hierarchy is:

```text
MaterialApp

↓

Scaffold

↓

SafeArea

↓

Feature Layout

↓

Feature Widgets
```

Avoid deeply nested widget trees whenever possible.

---

# Screen Lifecycle

Every screen follows the same lifecycle.

```text
Open Screen

↓

Read Provider

↓

Display Current State

↓

User Action

↓

Provider Action

↓

State Update

↓

UI Refresh
```

---

# State Rendering

Every asynchronous screen should support four primary states.

```text
Initial

↓

Loading

↓

Success

↓

Failure
```

The UI should clearly represent each state.

---

# Navigation

Screens never perform navigation using hardcoded routes.

Navigation must use the centralized GoRouter configuration.

This ensures:

* maintainability
* deep linking support
* consistent navigation

---

# Dependency Rules

Allowed

```text
Screen

↓

Provider
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

Datasource
```

Forbidden

```text
Screen

↓

Dio
```

Forbidden

```text
Screen

↓

Hive
```

---

# UI Composition

Large screens should be decomposed into reusable widgets.

Recommended structure

```text
screens/

dashboard_screen.dart

widgets/

dashboard_header.dart

dashboard_summary.dart

dashboard_chart.dart
```

This improves readability and reusability.

---

# Error Presentation

Screens display only user-friendly messages.

Raw exceptions, stack traces, and technical details must never be rendered directly.

---

# Accessibility

Every screen should:

* support responsive layouts
* support screen readers
* use semantic widgets where appropriate
* maintain sufficient color contrast
* avoid fixed dimensions unless necessary

---

# Testing

Screens should be tested using Widget Tests.

Business logic should be validated through Provider and Repository tests.

Screens should remain simple enough that most application logic can be tested without rendering widgets.

---

# Engineering Rules

Every screen must:

* Have a single responsibility.
* Represent one user-facing page.
* Delegate business logic to Providers.
* Avoid direct service access.
* Be responsive.
* Follow Material Design guidelines.
* Remain testable.

---

# Relationship with Other Documents

This document should be read together with:

* Flutter-Architecture.md
* Repository-Pattern.md
* Provider-Pattern.md
* Routing.md
* State-Management.md

Together these documents define the official presentation architecture for the DscienTia Flutter application.
