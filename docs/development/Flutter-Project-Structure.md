# Flutter Project Structure

## Purpose

This document defines the Flutter application architecture for the DscienTia AI Insight MVP.

The objective is to create a scalable and maintainable project structure that supports:

- AI-powered community intelligence
- Offline-first workflows
- Future IBM watsonx integration
- Multi-role user experiences
- Long-term platform growth

This architecture follows a feature-first approach.

---

# Architecture Principles

The Flutter application is designed according to the following principles:

## 1. Feature First

Features are organized by business capability rather than technical layer.

Benefits:

- Easier scalability
- Clear ownership
- Better maintainability

---

## 2. Modular Design

Each feature should remain independent whenever possible.

Benefits:

- Faster development
- Easier testing
- Reduced coupling

---

## 3. AI Ready

The architecture should support future AI services without requiring major restructuring.

---

## 4. Offline First

The application should support users working in low-connectivity environments.

---

## 5. Clean Separation of Concerns

UI, business logic, and data handling should remain separated.

---

# Recommended Folder Structure

```text
lib/
│
├── app/
│
│   ├── router/
│   │   └── app_router.dart
│   │
│   ├── theme/
│   │   ├── app_theme.dart
│   │   └── app_colors.dart
│   │
│   ├── constants/
│   │   ├── api_constants.dart
│   │   └── app_constants.dart
│   │
│   └── app.dart
│
├── features/
│
│   ├── auth/
│   │
│   ├── dashboard/
│   │
│   ├── reports/
│   │
│   ├── ai_insights/
│   │
│   ├── risks/
│   │
│   ├── recommendations/
│   │
│   └── projects/
│
├── shared/
│
│   ├── widgets/
│   ├── models/
│   ├── services/
│   ├── providers/
│   └── utils/
│
└── main.dart
```

---

# Feature Structure

Each feature should follow a consistent structure.

Example:

```text
features/reports/
│
├── data/
│
│   ├── models/
│   ├── repositories/
│   └── datasources/
│
├── presentation/
│
│   ├── screens/
│   ├── widgets/
│   └── providers/
│
└── domain/
    ├── entities/
    └── usecases/
```

---

# App Layer

## Responsibility

Contains application-wide configuration.

Includes:

- Routing
- Themes
- Constants
- Environment Configuration

---

# Shared Layer

## Responsibility

Contains reusable components.

Examples:

### Widgets

Reusable UI elements.

Examples:

- AppButton
- AppCard
- AppTextField
- LoadingIndicator

---

### Models

Shared data structures.

Examples:

- User
- Project
- Report

---

### Services

Application-wide services.

Examples:

- StorageService
- ApiService
- AIService

---

### Providers

Global Riverpod providers.

Examples:

- AuthProvider
- ThemeProvider

---

# Authentication Feature

## Responsibilities

- Login
- Logout
- Session Management

Screens:

- LoginScreen

Future:

- Registration
- Password Recovery

---

# Dashboard Feature

## Responsibilities

- User Overview
- Recent Activity
- AI Summary

Screens:

- DashboardScreen

---

# Reports Feature

## Responsibilities

- Submit Report
- View Reports
- Edit Drafts

Screens:

- ReportListScreen
- SubmitReportScreen
- ReportDetailScreen

---

# AI Insights Feature

## Responsibilities

- Insight Summary
- Trend Analysis
- Community Intelligence

Screens:

- AIInsightCenterScreen
- AIInsightDetailScreen

---

# Risk Assessment Feature

## Responsibilities

- Risk Detection
- Risk Review

Screens:

- RiskAssessmentScreen
- RiskDetailScreen

---

# Recommendation Feature

## Responsibilities

- Action Suggestions
- Intervention Guidance

Screens:

- RecommendationCenterScreen
- RecommendationDetailScreen

---

# Project Feature

## Responsibilities

- Project Overview
- Progress Tracking

Screens:

- ProjectListScreen
- ProjectDetailScreen

---

# State Management

## Selected Solution

Riverpod

Reason:

- Scalable
- Testable
- Modern Flutter Standard

---

# Navigation

## Selected Solution

GoRouter

Reason:

- Declarative Routing
- Deep Linking Support
- Better Scalability

---

# Local Storage

## MVP

SharedPreferences

Purpose:

- User Session
- Local Settings

---

## Future

Hive

Purpose:

- Offline Reports
- Cached AI Responses

---

# Network Layer

## MVP

REST API

Communication:

```text
Flutter App
      ↓
Laravel API
      ↓
PostgreSQL
```

---

# AI Integration Layer

## MVP

Mock AI Responses

Purpose:

Validate user experience before AI integration.

---

## Future

IBM watsonx.ai

Capabilities:

- Insight Generation
- Risk Detection
- Recommendation Generation

---

# Testing Strategy

## Unit Testing

Focus:

- Services
- Providers
- Business Logic

---

## Widget Testing

Focus:

- Forms
- Navigation
- User Interaction

---

## Integration Testing

Focus:

- Complete AI workflow

---

# MVP Deliverables

The Flutter MVP should provide:

✓ Login

✓ Dashboard

✓ Submit Report

✓ AI Insight Center

✓ Risk Assessment

✓ Recommendation Center

✓ Project Detail

---

# Related Documents

- MVP Scope
- User Journeys
- Navigation Flows
- Data Models
- API Contracts
- System Architecture