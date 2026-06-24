# Domain Overview

DscienTia connects organizations, communities, volunteers, and projects through a mobile-first impact reporting and intelligence platform.

Organization
    │
    ├── Projects
    │      ├── Activities
    │      ├── Reports
    │      └── Impact Metrics
    │
    └── Communities
            │
            ├── Volunteers
            └── Beneficiaries

Reports + Impact Metrics
          │
          ▼
      AI Insight
          │
          ├── Risk Assessment
          ├── Recommendation
          └── Impact Trend

The platform combines operational data collection with AI-powered intelligence services to support evidence-based decision making for social impact organizations.

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

# AI Intelligence Entities

The following entities are generated or enhanced by the AI Intelligence Layer.

---

## AI Insight

Represents AI-generated observations and analysis.

### Attributes

| Attribute | Description |
|------------|------------|
| insightId | Unique identifier |
| relatedReports | Analyzed reports |
| summary | Generated summary |
| modelSource | AI model generating insight |
| confidenceScore | AI confidence score |
| generatedAt | Creation date |

### Relationships

- One AI Insight may analyze many Reports
- One AI Insight may generate many Recommendations
- One AI Insight may identify multiple Risks
- One AI Insight may identify many Impact Trends

## Risk Assessment

Represents an AI-generated evaluation of community risks.

### Attributes

| Attribute | Description |
|------------|------------|
| riskId | Unique identifier |
| communityId | Related community |
| riskLevel | Low, Medium, High |
| confidenceScore | Confidence score |
| generatedAt | Creation date |

### Relationships

- One Community may have many Risk Assessments
- One Risk Assessment may produce many Recommendations

### Risk Levels

- Low
- Medium
- High
- Critical

## Recommendation

Represents AI-generated recommendations for action.

### Attributes

| Attribute | Description |
|------------|------------|
| recommendationId | Unique identifier |
| riskId | Associated risk |
| description | Recommendation text |
| priority | Low, Medium, High |
| generatedAt | Creation date |
| status | Pending, Accepted, Implemented |

### Relationships

- One Recommendation belongs to one Risk Assessment
- One Recommendation may support one or more Projects

### Priority Levels

- Low
- Medium
- High
- Critical

## Impact Trend

Represents AI-generated trend analysis across projects and communities.

### Attributes

| Attribute | Description |
|------------|------------|
| trendId | Unique identifier |
| metricName | Metric being analyzed |
| trendDirection | Increasing, Stable, Decreasing |
| confidenceScore | AI confidence |
| generatedAt | Creation date |

### Relationships

- One Impact Trend may analyze many Impact Metrics
- One Impact Trend may support many Recommendations

---

# Relationship Diagram

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
      └── Beneficiaries

Reports + Impact Metrics
          │
          ▼
      AI Insight
          │
          ├── Risk Assessment
          ├── Recommendation
          └── Impact Trend

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

## AI Assistant

Conversational assistant for project and community intelligence.

## Predictive Analytics

Forecasting future risks and intervention outcomes.

## Geospatial Intelligence

Location-based risk analysis and community mapping.

## Community Trend Monitoring

Longitudinal monitoring of community well-being indicators.

# AI Readiness

This domain model has been designed to support future AI-powered capabilities, including:

- Risk Detection
- Impact Trend Analysis
- Recommendation Generation
- Decision Support Intelligence
- Community Impact Forecasting

These capabilities will be implemented through the DscienTia AI Intelligence Layer.

---

# Version

Domain Model v0.3

AI Transformation Edition

Created: June 2026
Updated: June 2026

Related Documents:

- ADR-001 Mobile Platform Strategy
- Product Vision