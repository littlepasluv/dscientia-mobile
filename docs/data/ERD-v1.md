# Entity Relationship Diagram (ERD) v1

## Purpose

This document translates the DscienTia Domain Model into a relational database structure suitable for PostgreSQL implementation.

The ERD provides:

* Database design guidance
* API development support
* Backend implementation reference
* AI analytics data foundation

---

# Database Overview

The MVP database is organized around five primary domains:

1. Organizations
2. Communities
3. Projects
4. Reports
5. AI Intelligence

```text
Organization
    │
    ├── Users
    │
    ├── Projects
    │       │
    │       ├── Activities
    │       ├── Reports
    │       └── Impact Metrics
    │
    └── Communities
            │
            ├── Beneficiaries
            └── Risk Assessments

Reports
    │
    ▼
AI Insights
    │
    ├── Recommendations
    └── Impact Trends
```

---

# Entity Definitions

## organizations

Represents NGOs, foundations, and institutions.

### Fields

| Field               | Type      |
| ------------------- | --------- |
| id                  | UUID      |
| name                | VARCHAR   |
| description         | TEXT      |
| location            | VARCHAR   |
| contact_information | JSON      |
| created_at          | TIMESTAMP |
| updated_at          | TIMESTAMP |

---

## users

Represents authenticated platform users.

### Fields

| Field           | Type      |
| --------------- | --------- |
| id              | UUID      |
| organization_id | UUID FK   |
| full_name       | VARCHAR   |
| email           | VARCHAR   |
| role            | VARCHAR   |
| password_hash   | VARCHAR   |
| created_at      | TIMESTAMP |
| updated_at      | TIMESTAMP |

### Relationships

Many Users → One Organization

---

## communities

Represents target communities.

### Fields

| Field                    | Type      |
| ------------------------ | --------- |
| id                       | UUID      |
| name                     | VARCHAR   |
| location                 | VARCHAR   |
| population               | INTEGER   |
| vulnerability_indicators | JSON      |
| created_at               | TIMESTAMP |
| updated_at               | TIMESTAMP |

---

## projects

Represents social impact initiatives.

### Fields

| Field           | Type      |
| --------------- | --------- |
| id              | UUID      |
| organization_id | UUID FK   |
| title           | VARCHAR   |
| description     | TEXT      |
| start_date      | DATE      |
| end_date        | DATE      |
| status          | VARCHAR   |
| created_at      | TIMESTAMP |
| updated_at      | TIMESTAMP |

### Relationships

Many Projects → One Organization

---

## activities

Represents field activities.

### Fields

| Field         | Type      |
| ------------- | --------- |
| id            | UUID      |
| project_id    | UUID FK   |
| title         | VARCHAR   |
| description   | TEXT      |
| activity_date | DATE      |
| location      | VARCHAR   |
| created_at    | TIMESTAMP |

---

## reports

Represents field submissions.

### Fields

| Field        | Type      |
| ------------ | --------- |
| id           | UUID      |
| project_id   | UUID FK   |
| submitted_by | UUID FK   |
| title        | VARCHAR   |
| description  | TEXT      |
| category     | VARCHAR   |
| location     | VARCHAR   |
| media_url    | TEXT      |
| status       | VARCHAR   |
| submitted_at | TIMESTAMP |

---

## impact_metrics

Represents project KPIs.

### Fields

| Field        | Type      |
| ------------ | --------- |
| id           | UUID      |
| project_id   | UUID FK   |
| metric_name  | VARCHAR   |
| target_value | NUMERIC   |
| actual_value | NUMERIC   |
| updated_at   | TIMESTAMP |

---

# AI Intelligence Tables

## ai_insights

Generated summaries and observations.

### Fields

| Field            | Type      |
| ---------------- | --------- |
| id               | UUID      |
| project_id       | UUID FK   |
| summary          | TEXT      |
| confidence_score | DECIMAL   |
| model_source     | VARCHAR   |
| generated_at     | TIMESTAMP |

---

## risk_assessments

AI-generated risk evaluations.

### Fields

| Field            | Type      |
| ---------------- | --------- |
| id               | UUID      |
| community_id     | UUID FK   |
| risk_level       | VARCHAR   |
| confidence_score | DECIMAL   |
| generated_at     | TIMESTAMP |

---

## recommendations

AI-generated actions.

### Fields

| Field              | Type      |
| ------------------ | --------- |
| id                 | UUID      |
| risk_assessment_id | UUID FK   |
| description        | TEXT      |
| priority           | VARCHAR   |
| status             | VARCHAR   |
| generated_at       | TIMESTAMP |

---

## impact_trends

Trend analysis outputs.

### Fields

| Field            | Type      |
| ---------------- | --------- |
| id               | UUID      |
| metric_name      | VARCHAR   |
| trend_direction  | VARCHAR   |
| confidence_score | DECIMAL   |
| generated_at     | TIMESTAMP |

---

# MVP Database Scope

Included:

✓ Organizations

✓ Users

✓ Communities

✓ Projects

✓ Reports

✓ AI Insights

✓ Risk Assessments

✓ Recommendations

Excluded:

✗ Geospatial Intelligence

✗ Predictive Models

✗ External Datasets

✗ Multi-Tenant Administration

---

# Future Enhancements

Future database additions:

* Survey Responses
* Resource Distribution
* Incident Management
* Geospatial Data (PostGIS)
* AI Feedback Loop
* Impact Forecasting

---

# Version

ERD v1

Created: June 2026

Related Documents:

* Domain Model
* System Architecture
* Data Models
* API Contracts
