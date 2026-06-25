# AI Insight Workflow

## Purpose

This document defines the end-to-end workflow of the DscienTia AI Intelligence Engine.

The workflow describes how community data is transformed into actionable intelligence through IBM Granite models and DscienTia AI services.

This document serves as the operational blueprint for:

* AI Insight Generation
* Risk Assessment
* Recommendation Generation
* Impact Trend Analysis

---

# Workflow Overview

The DscienTia AI Intelligence Layer transforms field data into decision-support intelligence.

```text
Field Reports
      │
      ▼
Data Validation
      │
      ▼
AI Processing Pipeline
      │
      ▼
AI Insight Generation
      │
      ▼
Risk Assessment
      │
      ▼
Recommendation Generation
      │
      ▼
Dashboard Presentation
```

---

# Intelligence Lifecycle

The intelligence lifecycle consists of five stages:

1. Data Collection
2. Data Processing
3. AI Analysis
4. Intelligence Generation
5. Decision Support

---

# Stage 1 – Data Collection

## Sources

Community intelligence begins with field data.

### Report Sources

* Volunteer Reports
* Community Leader Reports
* Project Updates
* Survey Responses

### Example

```json
{
  "reportId": "RPT001",
  "category": "Water Access",
  "description": "Residents report reduced water availability."
}
```

---

# Stage 2 – Data Validation

## Purpose

Ensure incoming data is suitable for AI analysis.

---

## Validation Rules

### Required Fields

* Title
* Description
* Location
* Category

---

### Quality Checks

* Duplicate detection
* Empty report detection
* Invalid location detection

---

## Output

Validated report data.

```json
{
  "status": "validated"
}
```

---

# Stage 3 – AI Processing Pipeline

## Purpose

Prepare validated data for IBM Granite.

---

## Processing Steps

### Step 1

Normalize report content.

---

### Step 2

Extract structured information.

Examples:

* Issue Category
* Community
* Severity Indicators

---

### Step 3

Build AI Context Package.

Example:

```json
{
  "community": "Village A",
  "reports": [...],
  "metrics": [...]
}
```

---

# Stage 4 – AI Insight Generation

## Purpose

Generate high-level observations.

---

## IBM Granite Task

Input:

* Reports
* Metrics
* Community Context

Prompt:

AI Insight Prompt Template

---

## Output Example

```json
{
  "summary":
    "Water-related concerns increased across multiple communities.",
  "confidenceScore": 0.91
}
```

---

# Stage 5 – Risk Assessment

## Purpose

Determine risk levels.

---

## Inputs

* Community Reports
* Historical Trends
* Impact Metrics

---

## Evaluation Factors

### Severity

Impact magnitude.

---

### Frequency

Number of occurrences.

---

### Persistence

Duration of issue.

---

### Vulnerability

Community sensitivity.

---

## Risk Levels

* Low
* Medium
* High
* Critical

---

## Example Output

```json
{
  "riskLevel": "High",
  "confidenceScore": 0.88
}
```

---

# Stage 6 – Recommendation Generation

## Purpose

Suggest actionable interventions.

---

## Inputs

* AI Insight
* Risk Assessment

---

## Recommendation Criteria

### Relevance

Recommendation addresses identified risk.

---

### Feasibility

Recommendation is practical.

---

### Expected Impact

Potential positive outcome.

---

## Example Output

```json
{
  "priority": "High",
  "action":
    "Coordinate emergency water distribution."
}
```

---

# Stage 7 – Impact Trend Analysis

## Purpose

Identify trends across projects and communities.

---

## Inputs

* Historical Metrics
* Reports
* Project Outcomes

---

## Trend Categories

### Increasing

Positive or negative growth.

---

### Stable

No significant change.

---

### Decreasing

Reduction in indicators.

---

## Example Output

```json
{
  "trendDirection": "Increasing",
  "metric": "Community Participation"
}
```

---

# Stage 8 – Dashboard Delivery

## Purpose

Present intelligence to users.

---

## Volunteer View

Displays:

* Assigned Tasks
* Community Alerts

---

## Community Leader View

Displays:

* Local Risks
* Recommendations

---

## NGO Manager View

Displays:

* Portfolio Insights
* Risk Overview
* Impact Trends

---

## Researcher View

Displays:

* Community Patterns
* Historical Analysis
* Trend Reports

---

# Workflow Sequence Diagram

```text
Volunteer
   │
   ▼
Submit Report
   │
   ▼
Backend API
   │
   ▼
Validation Service
   │
   ▼
AI Pipeline
   │
   ▼
IBM Granite
   │
   ├── AI Insight
   ├── Risk Assessment
   └── Recommendations
   │
   ▼
Database
   │
   ▼
Dashboard
```

---

# Human-in-the-Loop Validation

## Purpose

Prevent unsafe automation.

---

## Rules

Low Confidence:

```text
confidenceScore < 0.60
```

Action:

Require manual review.

---

High Risk:

```text
riskLevel = Critical
```

Action:

Require human approval.

---

# Error Handling

## Missing Data

Response:

```json
{
  "status": "insufficient_data"
}
```

---

## AI Failure

Fallback:

```text
Unable to generate insight.
Human review required.
```

---

# IBM Granite Integration Point

The workflow interacts with:

* Granite Instruct Models
* Granite Reasoning Models

via:

* IBM watsonx.ai

Responsibilities:

* Summarization
* Risk Reasoning
* Recommendation Generation
* Trend Analysis

---

# Success Metrics

The AI workflow should achieve:

| Metric                       | Target     |
| ---------------------------- | ---------- |
| Insight Generation Success   | >95%       |
| API Response Time            | <5 seconds |
| Recommendation Relevance     | >80%       |
| Risk Classification Accuracy | >75%       |
| Human Review Rate            | <20%       |

---

# Version

AI Insight Workflow v0.1

Milestone:

v0.6 AI Insight MVP

Created: June 2026

Related Documents:

* AI Architecture
* Risk Scoring Model
* AI Prompt Templates
* API Contracts
* IBM WatsonX Integration
