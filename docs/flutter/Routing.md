# Routing

**Project:** DscienTia Mobile Application

**Version:** v0.8 Foundation Architecture

**Status:** Official Standard

---

# Purpose

This document defines the official navigation architecture for the DscienTia Flutter application.

The application uses **GoRouter** as the centralized routing solution.

All navigation must be declared in a single routing configuration to ensure consistency, maintainability, and future scalability.

---

# Objectives

The routing architecture is designed to:

* Centralize navigation.
* Support deep linking.
* Improve maintainability.
* Simplify feature integration.
* Enable route guards.
* Standardize AI-generated navigation code.

---

# Navigation Principles

The application follows these principles:

* All routes are centralized.
* Features never define their own router.
* Navigation should use named routes whenever possible.
* Authentication guards remain centralized.
* Navigation logic must not be duplicated.

---

# Architecture Position

```text
User

↓

Screen

↓

GoRouter

↓

Destination Screen
```

Routing exists between presentation layers only.

Business logic should never be placed inside route definitions.

---

# Routing Structure

The routing configuration is located inside:

```text
lib/

routes/

app_router.dart
```

Future route modules may be organized as:

```text
routes/

app_router.dart

auth_routes.dart

dashboard_routes.dart

report_routes.dart

settings_routes.dart
```

The main router aggregates all feature routes.

---

# Route Registration

Every feature exposes its routes through the centralized router.

Example feature registration:

```text
Authentication

↓

Dashboard

↓

Reports

↓

AI Insight

↓

Settings
```

Each feature contributes routes without owning the navigation system.

---

# Navigation Flow

Standard navigation flow:

```text
User Action

↓

GoRouter

↓

Route Match

↓

Screen Build
```

---

# Named Routes

Named routes are preferred over hardcoded path navigation.

Benefits include:

* easier refactoring
* improved readability
* compile-time safety
* centralized management

---

# Authentication Guards

Protected pages should be controlled using GoRouter redirect logic.

Example protected areas include:

* Dashboard
* AI Insight
* Reports
* Profile
* Settings

Public pages include:

* Splash
* Login
* Register
* Forgot Password

---

# Deep Linking

The routing architecture should support future deep linking without structural changes.

Examples include:

* Opening a specific report
* Opening an AI Insight
* Opening a project detail
* Opening a notification

---

# Dependency Rules

Allowed

```text
Screen

↓

GoRouter
```

Forbidden

```text
Repository

↓

GoRouter
```

Forbidden

```text
Datasource

↓

GoRouter
```

Navigation belongs exclusively to the presentation layer.

---

# Error Routing

Unknown routes should display a dedicated error page.

Possible examples include:

* 404 Not Found
* Unauthorized
* Session Expired

These screens should provide clear recovery actions for the user.

---

# Future Expansion

The routing architecture is designed to support:

* Nested navigation
* Bottom navigation
* ShellRoute
* Authentication redirects
* Role-based navigation
* Deep linking
* Web navigation

No architectural changes should be required when these capabilities are introduced.

---

# Engineering Rules

Every route must:

* Be declared centrally.
* Use GoRouter.
* Prefer named routes.
* Avoid duplicate paths.
* Avoid navigation inside repositories.
* Avoid navigation inside data sources.

---

# Relationship with Other Documents

This document should be read together with:

* Flutter-Architecture.md
* Screen-Pattern.md
* Provider-Pattern.md
* Repository-Pattern.md

Together these documents define the official navigation architecture for the DscienTia Flutter application.
