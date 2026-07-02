# Theming

**Project:** DscienTia Mobile Application

**Version:** v0.8 Foundation Architecture

**Status:** Official Standard

---

# Purpose

This document defines the official theming architecture for the DscienTia Flutter application.

The application uses a centralized Material Design 3 theme to ensure visual consistency across all features and platforms.

All colors, typography, spacing, and component styling must originate from the shared theme configuration.

---

# Objectives

The theming architecture is designed to:

* Ensure visual consistency.
* Support Material Design 3.
* Centralize design tokens.
* Improve maintainability.
* Support light and dark themes.
* Standardize AI-generated UI implementations.

---

# Design Principles

The application follows these principles:

* Single source of truth.
* Material Design 3.
* Responsive layouts.
* Accessible color contrast.
* Consistent typography.
* Reusable components.

---

# Architecture Position

```text
MaterialApp

↓

ThemeData

↓

Shared Widgets

↓

Feature Screens
```

Themes are configured once and consumed throughout the application.

---

# Theme Structure

The theme implementation resides inside:

```text
lib/

core/

theme/
```

Recommended structure:

```text
core/

theme/

app_theme.dart

app_colors.dart

app_typography.dart

app_spacing.dart

app_radius.dart
```

Each file has a single responsibility.

---

# Color System

The application defines centralized color tokens.

Examples include:

* Primary
* Secondary
* Surface
* Background
* Error
* Success
* Warning
* Information

Screens should never define custom colors directly.

---

# Typography

Typography should follow Material Design 3.

Recommended hierarchy:

* Display
* Headline
* Title
* Body
* Label

Font sizes and weights should remain consistent across the application.

---

# Spacing

Spacing should use predefined values instead of arbitrary numbers.

Recommended spacing scale:

```text
4
8
12
16
20
24
32
40
48
64
```

Avoid hardcoded spacing values unless absolutely necessary.

---

# Border Radius

Corner radius should use shared design tokens.

Recommended values:

```text
Small

8

Medium

12

Large

16

Extra Large

24
```

Do not define radius values inside individual widgets.

---

# Icons

The application uses Material Symbols by default.

Custom icon libraries should only be introduced when a functional requirement exists.

---

# Component Styling

Buttons

Cards

Dialogs

Navigation Bars

Text Fields

Chips

Badges

All component styling should inherit from the centralized theme.

Individual screens should avoid overriding component styles.

---

# Dark Mode

The architecture supports both:

* Light Theme
* Dark Theme

Both themes should share identical design tokens whenever possible.

Only colors should differ between theme modes.

---

# Responsive Design

The UI should adapt to:

* Phones
* Tablets
* Desktop
* Web

Avoid fixed widths and heights where possible.

Favor flexible layouts.

---

# Accessibility

The theme should support:

* High contrast.
* Readable typography.
* Large touch targets.
* Semantic colors.
* Screen readers.

Accessibility should be considered part of the default design rather than an optional enhancement.

---

# Dependency Rules

Allowed

```text
Screen

↓

AppTheme
```

Forbidden

```text
Screen

↓

Custom ThemeData
```

Forbidden

```text
Widget

↓

Random Colors
```

Forbidden

```text
Widget

↓

Inline TextStyle
```

Presentation should consume shared theme resources instead of creating local styles.

---

# Future Expansion

The theming architecture supports:

* Dynamic color.
* Brand customization.
* White-label deployments.
* Seasonal themes.
* User personalization.

No architectural changes should be required when these capabilities are introduced.

---

# Engineering Rules

Every feature must:

* Use AppTheme.
* Use shared colors.
* Use shared typography.
* Use shared spacing.
* Avoid inline styling.
* Follow Material Design 3.

---

# Relationship with Other Documents

This document should be read together with:

* Flutter-Architecture.md
* Screen-Pattern.md
* Folder-Structure.md

Together these documents define the official visual design architecture for the DscienTia Flutter application.
