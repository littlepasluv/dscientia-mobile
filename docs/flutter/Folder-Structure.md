# Folder Structure

**Version:** v0.8 Foundation Architecture

---

# Purpose

This document defines the official folder organization for the DscienTia Flutter application.

The objective is to ensure that every feature follows the same structure throughout the lifetime of the project.

---

# Root Structure

```text
lib/

core/
shared/
features/
routes/

main.dart
```

---

# Core

The **core** directory contains application-wide services and infrastructure.

```text
core/

config/
constants/
errors/
network/
services/
theme/
```

Core modules must never depend on feature modules.

---

# Shared

The **shared** directory contains reusable components.

```text
shared/

models/
utils/
widgets/
```

Anything placed here should be reusable by multiple features.

---

# Features

Each feature is completely isolated.

```text
features/

authentication/
dashboard/
reports/
risk_assessment/
recommendations/
ai_insight/
```

Each feature owns its own:

* models
* repositories
* providers
* screens
* widgets

Features should never directly access another feature.

Communication must occur through shared abstractions.

---

# Routing

Application routing remains centralized.

```text
routes/
```

GoRouter configuration should never be duplicated inside feature modules.

---

# Engineering Rules

The following rules apply throughout the project.

* One responsibility per directory.
* Features remain independent.
* Shared code belongs inside `/shared`.
* Global services belong inside `/core`.
* UI should never access APIs directly.
* Widgets must remain lightweight.
* Business logic belongs outside the presentation layer.

---

# Future Expansion

The folder structure is intentionally designed to support:

* Offline-first architecture
* AI-powered workflows
* Modular feature expansion
* Enterprise-scale maintenance

New features should extend the existing structure rather than introducing new architectural patterns.

---

## Bootstrap

The bootstrap layer is responsible for application startup.

Responsibilities include:

- Initializing Flutter bindings
- Loading environment configuration
- Initializing local storage
- Registering future services
- Preparing dependency injection
- Launching the application

Current location:

lib/bootstrap/