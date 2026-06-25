# Navigation Flows

## Purpose

This document defines the navigation structure and screen transitions for the DscienTia AI Insight MVP.

The navigation design aims to:

- Minimize user friction
- Support field-based workflows
- Enable AI-powered decision support
- Provide a scalable routing structure

This document serves as the foundation for:

- Flutter Navigation
- GoRouter Configuration
- UX Implementation
- MVP Testing

---

# Navigation Overview

The MVP follows a role-aware navigation model.

```text
Authentication
       │
       ▼
Dashboard
       │
       ├── Reports
       │
       ├── AI Insights
       │
       ├── Risk Assessment
       │
       ├── Recommendations
       │
       ├── Projects
       │
       └── Profile
```

---

# Application Entry Flow

```text
Launch App
      │
      ▼
Splash Screen
      │
      ▼
Authentication Check
      │
      ├── Authenticated
      │         │
      │         ▼
      │    Dashboard
      │
      └── Not Authenticated
                │
                ▼
             Login
```

---

# Authentication Flow

## Login Flow

```text
Login Screen
      │
      ▼
Validate Credentials
      │
      ├── Success
      │         │
      │         ▼
      │     Dashboard
      │
      └── Failure
                │
                ▼
          Error Message
```

---

# Dashboard Flow

The Dashboard acts as the central navigation hub.

```text
Dashboard
    │
    ├── Submit Report
    │
    ├── AI Insight Center
    │
    ├── Risk Assessment
    │
    ├── Recommendation Center
    │
    ├── Project Detail
    │
    └── Profile
```

---

# Report Submission Flow

## Primary User

Volunteer

---

```text
Dashboard
      │
      ▼
Submit Report
      │
      ▼
Review Report
      │
      ▼
Confirmation
      │
      ▼
Dashboard
```

---

# AI Insight Flow

## Goal

Review AI-generated intelligence.

---

```text
Dashboard
      │
      ▼
AI Insight Center
      │
      ▼
Insight Detail
      │
      ▼
Dashboard
```

---

# Risk Assessment Flow

## Goal

Understand community risks.

---

```text
Dashboard
      │
      ▼
Risk Assessment
      │
      ▼
Risk Detail
      │
      ▼
Dashboard
```

---

# Recommendation Flow

## Goal

Review suggested actions.

---

```text
Dashboard
      │
      ▼
Recommendation Center
      │
      ▼
Recommendation Detail
      │
      ▼
Dashboard
```

---

# Project Monitoring Flow

## Primary User

NGO Manager

---

```text
Dashboard
      │
      ▼
Project Detail
      │
      ▼
Impact Metrics
      │
      ▼
AI Insights
      │
      ▼
Recommendations
```

---

# Bottom Navigation Structure

The MVP will use a Bottom Navigation Bar.

```text
Home
Reports
AI Insights
Projects
Profile
```

---

# Navigation Tab Responsibilities

## Home

Displays:

- Dashboard
- Alerts
- Summary Cards

---

## Reports

Displays:

- Submitted Reports
- Draft Reports
- New Report Action

---

## AI Insights

Displays:

- Insight Summary
- Trends
- Risk Intelligence

---

## Projects

Displays:

- Assigned Projects
- Project Status
- Impact Metrics

---

## Profile

Displays:

- User Information
- Organization
- Settings

---

# Deep Navigation Hierarchy

```text
Home
│
├── Dashboard
│
├── Reports
│   ├── Report List
│   ├── Report Detail
│   └── Submit Report
│
├── AI Insights
│   ├── Insight Center
│   └── Insight Detail
│
├── Risks
│   ├── Risk Assessment
│   └── Risk Detail
│
├── Recommendations
│   ├── Recommendation Center
│   └── Recommendation Detail
│
├── Projects
│   ├── Project List
│   └── Project Detail
│
└── Profile
```

---

# GoRouter Route Design

## Authentication

```text
/login
```

---

## Dashboard

```text
/dashboard
```

---

## Reports

```text
/reports

/reports/new

/reports/:id
```

---

## AI Insights

```text
/insights

/insights/:id
```

---

## Risks

```text
/risks

/risks/:id
```

---

## Recommendations

```text
/recommendations

/recommendations/:id
```

---

## Projects

```text
/projects

/projects/:id
```

---

## Profile

```text
/profile
```

---

# MVP Navigation Scope

Included:

✓ Login

✓ Dashboard

✓ Reports

✓ AI Insights

✓ Risks

✓ Recommendations

✓ Projects

✓ Profile

---

Excluded:

✗ Notifications Center

✗ Chat System

✗ Donor Portal

✗ Marketplace

✗ Admin Portal

---

# Success Criteria

Users can:

- Reach any screen within three taps
- Navigate between all MVP modules
- Return to Dashboard easily
- Access AI intelligence workflows intuitively

---

# Related Documents

- MVP Scope
- User Journeys
- Flutter Project Structure
- Information Architecture