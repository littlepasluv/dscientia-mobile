# Information Architecture

## Purpose

This document defines the structure, navigation, and user flow of the DscienTia Mobile application.

The goal is to ensure a consistent user experience while supporting community impact reporting, project monitoring, and AI-assisted decision support.

This document serves as a bridge between:

* Product Vision
* User Personas
* Domain Model
* Flutter Application Development

---

# Application Overview

DscienTia Mobile is an AI-powered community impact intelligence platform designed for:

* NGOs and Foundations
* Community Leaders
* Volunteers
* Researchers

The application supports data collection, project monitoring, and impact analysis through a mobile-first experience.

---

# User Roles

## Volunteer

Primary responsibilities:

* Submit field reports
* Upload photos
* Complete surveys
* Track assigned activities

---

## Community Leader

Primary responsibilities:

* Monitor community activities
* Validate reports
* Coordinate volunteers
* Escalate local issues

---

## NGO Program Manager

Primary responsibilities:

* Monitor projects
* Review impact reports
* Analyze program outcomes
* Generate donor reports

---

# Navigation Structure

```text
Authentication
│
├── Login
├── Register
└── Forgot Password

Home
│
├── Dashboard
├── Reports
├── Projects
├── Notifications
└── Profile
```

---

# Application Modules

## Module 1: Authentication

Purpose:

Provide secure user access.

Screens:

* Login Screen
* Registration Screen
* Forgot Password Screen

Future Features:

* Social Login
* Single Sign-On
* Multi-Factor Authentication

---

## Module 2: Dashboard

Purpose:

Provide users with a summary of activities and updates.

Displayed Information:

* Recent reports
* Assigned projects
* Notifications
* AI-generated insights

Role-specific dashboards may vary.

---

## Module 3: Report Management

Purpose:

Allow users to create and manage field reports.

Screens:

### Report List

Displays:

* Submitted reports
* Draft reports
* Pending reviews

### Report Detail

Displays:

* Description
* Location
* Photos
* Status
* Review history

### Submit Report

Input Fields:

* Title
* Description
* Category
* Location
* Photos
* Impact estimate

---

## Module 4: Project Management

Purpose:

Track social initiatives and community programs.

Screens:

### Project List

Displays:

* Active projects
* Completed projects
* Upcoming projects

### Project Detail

Displays:

* Objectives
* Timeline
* Assigned members
* Progress indicators

---

## Module 5: Notifications

Purpose:

Provide real-time communication and updates.

Examples:

* Report approved
* Project updated
* Community alert
* AI-generated recommendations

---

## Module 6: User Profile

Purpose:

Manage user information.

Features:

* Personal profile
* Organization affiliation
* Skills
* Volunteer history

---

# AI Intelligence Module

## Purpose

Transform raw field data into actionable insights.

---

## AI Insight Summary

Input:

* Reports
* Surveys
* Project updates

Output:

* Trend summary
* Impact overview
* Community observations

Example:

Water-related incidents increased by 25% compared to last month.

---

## Risk Detection

Purpose:

Identify emerging issues before they become critical.

Examples:

* Repeated reports in the same area
* Escalating community concerns
* Resource shortages

Output:

Risk Level:

* Low
* Medium
* High

---

## Action Recommendations

Purpose:

Provide suggested next actions.

Example:

Issue:
Water shortage

Recommendation:
Coordinate water distribution within 14 days.

---

# MVP Scope (Version 1)

The first production-ready MVP will include:

## Included

* Login
* Dashboard
* Submit Report
* View Reports
* Notifications
* Basic AI Insight Summary

## Excluded

* Chat System
* Donor Portal
* Advanced Analytics
* Payment Features
* Multi-Organization Administration

---

# Navigation Flow

## Volunteer Flow

```text
Login
  ↓
Dashboard
  ↓
Submit Report
  ↓
Review Submission
  ↓
Receive Notifications
```

---

## Community Leader Flow

```text
Login
  ↓
Dashboard
  ↓
Review Reports
  ↓
Monitor Projects
  ↓
Issue Updates
```

---

## NGO Manager Flow

```text
Login
  ↓
Dashboard
  ↓
Project Monitoring
  ↓
Impact Reports
  ↓
AI Insights
```

---

# Offline-First Considerations

The application should support:

* Offline report creation
* Local data storage
* Background synchronization
* Draft recovery

This requirement is particularly important for users operating in remote areas with unstable internet connectivity.

---

# Future Expansion

Potential future modules:

* Research Analytics
* Donor Reporting Portal
* Community Marketplace
* AI Chat Assistant
* Predictive Impact Modeling

---

# Version

Information Architecture v0.4

Created: June 2026

Related Documents:

* Product Vision
* ADR-001 Mobile Platform Strategy
* Domain Model
* User Personas

```
```
