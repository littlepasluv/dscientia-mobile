# Domain Model

## Purpose

This document defines the core business entities of DscienTia Mobile and their relationships.

The domain model serves as the foundation for:

- Mobile application design
- Database architecture
- API development
- Analytics and reporting
- Future AI-assisted insights

---

# Domain Overview

DscienTia connects organizations, communities, volunteers, and projects through a mobile-first impact reporting platform.

```text
Organization
    │
    ├── Project
    │      ├── Activity
    │      ├── Report
    │      └── Impact Metric
    │
    └── Community
            │
            ├── Volunteer
            ├── Beneficiary
            └── Report
```

---

# Core Entities

## User

Represents a person using the DscienTia platform.

### Attributes

| Attribute | Description |
|------------|------------|
| userId | Unique identifier |
| fullName | User full name |
| email | User email |
| role | User role |
| organizationId | Associated organization |

### Roles

- Admin
- NGO Manager
- Community Leader
- Volunteer
- Researcher

---

## Organization

Represents NGOs, foundations, social enterprises, or institutions managing projects.

### Attributes

| Attribute | Description |
|------------|------------|
| organizationId | Unique identifier |
| name | Organization name |
| description | Organization overview |
| location | Main location |
| contactInformation | Contact details |

### Relationships

- One Organization manages many Projects
- One Organization serves many Communities
- One Organization has many Users

---

## Community

Represents a target community or geographic area.

### Attributes

| Attribute | Description |
|------------|------------|
| communityId | Unique identifier |
| name | Community name |
| location | Geographic location |
| population | Estimated population |
| vulnerabilityIndicators | Community risk indicators |

### Relationships

- One Community belongs to many Projects
- One Community has many Volunteers
- One Community has many Beneficiaries

---

## Project

Represents a social impact initiative.

### Attributes

| Attribute | Description |
|------------|------------|
| projectId | Unique identifier |
| title | Project title |
| description | Project description |
| startDate | Project start date |
| endDate | Project end date |
| status | Project status |

### Status

- Planned
- Active
- Completed
- Archived

### Relationships

- One Project belongs to one Organization
- One Project contains many Activities
- One Project receives many Reports
- One Project tracks many Impact Metrics

---

## Volunteer

Represents a field contributor participating in projects.

### Attributes

| Attribute | Description |
|------------|------------|
| volunteerId | Unique identifier |
| userId | Associated user account |
| skills | Volunteer skills |
| assignedProjects | Active project assignments |

### Relationships

- One Volunteer submits many Reports
- One Volunteer participates in many Activities

---

## Beneficiary

Represents individuals or groups receiving support.

### Attributes

| Attribute | Description |
|------------|------------|
| beneficiaryId | Unique identifier |
| communityId | Associated community |
| category | Beneficiary type |
| demographicInformation | Demographic data |

### Categories

- Household
- Student
- Youth
- Women Group
- Elderly
- Small Business

---

## Activity

Represents field activities conducted under a project.

### Attributes

| Attribute | Description |
|------------|------------|
| activityId | Unique identifier |
| projectId | Associated project |
| date | Activity date |
| location | Activity location |
| description | Activity details |

### Examples

- Training Session
- Community Meeting
- Survey Collection
- Resource Distribution
- Workshop

---

## Report

Represents evidence or updates submitted from the field.

### Attributes

| Attribute | Description |
|------------|------------|
| reportId | Unique identifier |
| projectId | Associated project |
| submittedBy | User submitting report |
| submissionDate | Submission timestamp |
| mediaAttachments | Photos or documents |
| notes | Additional observations |

### Report Types

- Progress Update
- Survey Result
- Incident Report
- Impact Evidence

---

## Impact Metric

Represents measurable outcomes.

### Attributes

| Attribute | Description |
|------------|------------|
| metricId | Unique identifier |
| projectId | Associated project |
| metricName | Metric title |
| targetValue | Expected value |
| actualValue | Achieved value |

### Examples

- Number of beneficiaries reached
- Number of volunteers engaged
- Training completion rate
- Community satisfaction score

---

# Relationship Diagram

```text
Organization
│
├── Users
│
├── Projects
│     │
│     ├── Activities
│     ├── Reports
│     └── Impact Metrics
│
└── Communities
      │
      ├── Volunteers
      ├── Beneficiaries
      └── Reports
```

---

# Future Expansion

The following entities may be introduced in future versions:

## Survey

Structured data collection forms.

## Incident Report

Emergency or issue reporting.

## Resource Distribution

Tracking aid and resource allocation.

## Dataset

Historical data for analytics.

## AI Insight

Automatically generated findings.

## Recommendation Engine

Suggested actions based on community conditions.

---

# Version

Domain Model v0.2

Created: June 2026

Related Documents:

- ADR-001 Mobile Platform Strategy
- Product Vision