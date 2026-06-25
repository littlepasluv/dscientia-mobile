# Risk Scoring Model

## Purpose

This document defines how DscienTia calculates community risk levels using AI-assisted impact intelligence.

The Risk Scoring Model transforms community reports, project data, and impact indicators into a measurable risk score that helps organizations prioritize interventions.

The model serves as the foundation for:

* Community Risk Detection
* AI Recommendations
* Decision Support
* Impact Monitoring
* Future Predictive Analytics

---

# Risk Intelligence Vision

Traditional reporting systems display information.

DscienTia evaluates information and identifies risk before problems escalate.

The objective is to answer:

* Which communities require urgent attention?
* Which issues are increasing?
* Which projects are underperforming?
* Where should resources be allocated first?

---

# Risk Assessment Framework

The DscienTia Risk Engine evaluates risk using multiple dimensions.

```text
Community Reports
        │
        ▼
Issue Frequency
        │
        ▼
Impact Severity
        │
        ▼
Trend Analysis
        │
        ▼
Risk Score
        │
        ▼
Risk Level
```

---

# Risk Dimensions

## Dimension 1: Issue Frequency

Measures how often a problem appears.

Examples:

* Water shortages
* Food insecurity
* Health incidents
* Infrastructure damage

### Formula

```text
Frequency Score =
(Number of Similar Reports)
÷
(Time Period)
```

### Example

25 water-related reports

during

30 days

Result:

High Frequency

---

## Dimension 2: Impact Severity

Measures seriousness of reported issues.

### Severity Scale

| Severity | Score |
| -------- | ----- |
| Minor    | 1     |
| Moderate | 2     |
| Serious  | 3     |
| Critical | 4     |

### Example

Water shortage affecting:

* 3 households = Moderate
* 100 households = Critical

---

## Dimension 3: Population Exposure

Measures how many people are affected.

### Formula

```text
Affected Population
÷
Community Population
```

### Example

Affected:

200 people

Population:

1000 people

Exposure:

20%

---

## Dimension 4: Trend Acceleration

Measures whether issues are increasing or decreasing.

### Trend Direction

* Decreasing
* Stable
* Increasing

### Example

Month 1:

10 reports

Month 2:

18 reports

Increase:

80%

Trend:

Increasing

---

## Dimension 5: Project Response Gap

Measures difference between community needs and project actions.

### Example

Detected Issues:

20

Resolved Issues:

5

Gap:

15

Large gap indicates elevated risk.

---

# Risk Score Formula

Version 1 MVP Formula:

```text
Risk Score =
(Frequency × 30%)
+
(Severity × 25%)
+
(Exposure × 20%)
+
(Trend × 15%)
+
(Response Gap × 10%)
```

Maximum Score:

100

Minimum Score:

0

---

# Risk Level Classification

## Low Risk

Score:

0 – 24

Meaning:

Normal conditions.

Action:

Continue monitoring.

---

## Medium Risk

Score:

25 – 49

Meaning:

Emerging concern.

Action:

Review community situation.

---

## High Risk

Score:

50 – 74

Meaning:

Significant issue detected.

Action:

Immediate intervention planning.

---

## Critical Risk

Score:

75 – 100

Meaning:

Urgent response required.

Action:

Escalate to organization leadership.

---

# AI-Assisted Risk Evaluation

The AI Intelligence Layer enhances scoring through contextual analysis.

IBM Granite analyzes:

* Report descriptions
* Historical incidents
* Community conditions
* Project outcomes

The model identifies patterns that numeric calculations may miss.

---

# Example Scenario

## Community A

Reports:

* Water shortage
* Water shortage
* Water shortage
* Water shortage

Population Affected:

150 households

Trend:

Increasing

Project Response:

Minimal

---

Calculated Risk Score

| Factor       | Score |
| ------------ | ----- |
| Frequency    | 85    |
| Severity     | 75    |
| Exposure     | 70    |
| Trend        | 90    |
| Response Gap | 80    |

---

Final Risk Score

```text
81
```

Risk Level:

```text
Critical
```

---

# Confidence Score

Every risk assessment includes confidence levels.

## Formula

Based on:

* Data completeness
* Report quality
* Historical consistency
* AI certainty

### Confidence Levels

| Confidence | Interpretation    |
| ---------- | ----------------- |
| 0–59%      | Low Confidence    |
| 60–79%     | Medium Confidence |
| 80–100%    | High Confidence   |

---

# Recommendation Mapping

Risk levels automatically trigger recommendation priorities.

| Risk Level | Recommendation Priority |
| ---------- | ----------------------- |
| Low        | Low                     |
| Medium     | Medium                  |
| High       | High                    |
| Critical   | Critical                |

---

# Dashboard Visualization

Users will see:

```text
Community: River Village

Risk Score: 81

Risk Level: Critical

Confidence: 89%

Top Issues:
- Water Shortage
- Sanitation Concerns

Recommended Action:
Deploy emergency assessment team.
```

---

# MVP Scope

Version 1 includes:

* Frequency Analysis
* Severity Analysis
* Exposure Analysis
* Trend Analysis
* Risk Classification

Excluded:

* Machine Learning Models
* Predictive Forecasting
* Resource Optimization
* Geospatial Intelligence

---

# Future Evolution

## Phase 2

Predictive Risk Scoring

Forecast future risk levels.

---

## Phase 3

Geospatial Risk Intelligence

Location-based risk mapping.

---

## Phase 4

Intervention Effectiveness Analysis

Measure which actions reduce risk most effectively.

---

## Phase 5

Adaptive AI Scoring

The model dynamically adjusts weighting based on historical outcomes.

---

# IBM AI Builders Challenge Alignment

The Risk Scoring Model demonstrates:

* Explainable AI
* Social Impact Intelligence
* Decision Support Systems
* Community Risk Detection
* Responsible AI Design

This component serves as the core intelligence engine of DscienTia.

---

# Version

Risk Scoring Model v1.0

Created: June 2026

Related Documents:

* AI Use Cases
* AI Data Pipeline
* AI Architecture
* Domain Model
* IBM watsonx Integration
