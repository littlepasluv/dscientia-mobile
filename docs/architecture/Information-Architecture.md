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

The application supports data collection, project monitoring, risk detection, and impact analysis through a mobile-first experience.

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

## Researcher / Impact Analyst

Primary responsibilities:

* Analyze impact trends
* Review AI-generated insights
* Compare community outcomes
* Export findings for research and policy development

---

# Navigation Structure

```text
Authentication
│
├── Login
├── Register
└── Forgot Password

Main Application
│
├── Dashboard
├── Reports
├── Projects
├── AI Intelligence
├── Notifications
└── Profile
```

---

# Application Modules

## Module 1: Authentication

### Purpose

Provide secure user access.

### Screens

* Login Screen
* Registration Screen
* Forgot Password Screen

### Future Features

* Social Login
* Single Sign-On
* Multi-Factor Authentication

---

## Module 2: Dashboard

### Purpose

Provide users with a summary of activities and updates.

### Displayed Information

* Recent reports
* Assigned projects
* Notifications
* AI-generated insights

### Research Dashboard

* Impact trends
* Community comparisons
* AI-generated summaries
* Exportable analytics

Role-specific dashboards may vary depending on permissions.

---

## Module 3: Report Management

### Purpose

Allow users to create and manage field reports.

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

### Purpose

Track social initiatives and community programs.

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
* Impact metrics

---

## Module 5: AI Intelligence Center

### Purpose

Transform raw field data into actionable insights.

This module represents the intelligence layer of DscienTia.

---

### AI Insight Summary

#### Input

* Reports
* Surveys
* Project updates
* Impact metrics

#### Output

* Trend summary
* Impact overview
* Community observations

Example:

> Water-related incidents increased by 25% compared to last month.

---

### Risk Detection

#### Purpose

Identify emerging issues before they become critical.

#### Examples

* Repeated reports in the same area
* Escalating community concerns
* Resource shortages
* Declining participation rates

#### Output

Risk Levels:

* Low
* Medium
* High
* Critical

---

### Action Recommendations

#### Purpose

Provide suggested next actions based on detected risks and impact trends.

Example:

Issue:
Water shortage

Recommendation:
Coordinate water distribution within 14 days.

---

### Impact Trends

#### Purpose

Analyze historical project and community data to identify long-term impact patterns.

#### Outputs

* Increasing trend
* Stable trend
* Declining trend

#### Examples

* Volunteer participation increasing
* Community satisfaction decreasing
* Program adoption remaining stable

---

## Module 6: Notifications

### Purpose

Provide real-time communication and updates.

### Examples

* Report approved
* Project updated
* Community alert
* AI-generated recommendation available
* High-risk community detected

---

## Module 7: User Profile

### Purpose

Manage user information.

### Features

* Personal profile
* Organization affiliation
* Skills
* Volunteer history
* Activity statistics

---

# MVP Scope (Version 1)

The first production-ready MVP will include:

## Included

* Login
* Dashboard
* Submit Report
* View Reports
* Projects
* Notifications
* Basic AI Insight Summary
* Basic Risk Detection

## Excluded

* Chat System
* Donor Portal
* Advanced Analytics
* Payment Features
* Multi-Organization Administration
* Predictive Analytics

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

## Researcher Flow

```text
Login
  ↓
Dashboard
  ↓
AI Intelligence
  ↓
Impact Trends
  ↓
Recommendations
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

## Research Analytics

Advanced impact analysis for researchers and institutions.

## Donor Reporting Portal

Dedicated transparency and reporting portal.

## Community Marketplace

Local resource and opportunity exchange platform.

## AI Chat Assistant

Conversational assistant for project and community intelligence.

## Predictive Impact Modeling

Forecast future community risks and intervention outcomes.

## Geospatial Intelligence

Location-based risk mapping and visualization.

---

# AI Readiness

This information architecture is designed to support:

* AI Insight Generation
* Community Risk Detection
* Recommendation Generation
* Impact Trend Analysis
* Future Predictive Analytics

These capabilities are delivered through the DscienTia AI Intelligence Layer.

---

# Version

Information Architecture v0.5

AI Transformation Edition

Created: June 2026

Updated: June 2026

Related Documents:

* Product Vision
* User Personas
* Domain Model
* ADR-001 Mobile Platform Strategy
