# AI Prompt Templates

## Purpose

This document defines the prompt engineering framework used by DscienTia AI Intelligence Services.

The objective is to ensure that IBM Granite models generate:

* Reliable outputs
* Consistent recommendations
* Explainable insights
* Actionable community intelligence

This document serves as the foundation for:

* AI Insight Generation
* Risk Assessment
* Recommendation Generation
* Impact Trend Analysis

---

# Prompt Engineering Strategy

DscienTia adopts a structured prompting approach.

Every AI request consists of:

```text
System Prompt
      +
Context Data
      +
User Request
      +
Output Format
```

This structure improves:

* Accuracy
* Consistency
* Explainability
* Auditability

---

# AI Design Principles

The AI system should:

1. Focus on community impact.
2. Avoid unsupported assumptions.
3. Clearly indicate uncertainty.
4. Provide evidence-based conclusions.
5. Generate actionable recommendations.
6. Prioritize vulnerable communities.

---

# Standard System Prompt

The following system prompt is used across all AI services.

```text
You are DscienTia AI, an expert community impact intelligence assistant.

Your responsibility is to analyze social impact reports,
community observations, project updates, and impact metrics.

Your goals are:

- Identify emerging community risks
- Detect impact trends
- Generate evidence-based recommendations
- Support NGO and community decision making

Always explain reasoning clearly.

Do not invent information.

If confidence is low, explicitly state uncertainty.

Return outputs using the requested format only.
```

---

# AI Insight Prompt

## Purpose

Generate a concise summary from multiple reports.

---

## Input

```json
{
  "reports": [
    {
      "title": "Water Supply Issue",
      "description": "Community members report reduced water access."
    }
  ]
}
```

---

## Prompt

```text
Analyze the following community reports.

Identify:

1. Key observations
2. Emerging patterns
3. Potential impact

Generate a concise summary.

Reports:

{{reports}}
```

---

## Expected Output

```json
{
  "summary": "Water access concerns increased across multiple communities.",
  "confidenceScore": 0.88
}
```

---

# Risk Assessment Prompt

## Purpose

Evaluate community risk levels.

---

## Input

```json
{
  "community": "Village A",
  "reports": "...",
  "metrics": "..."
}
```

---

## Prompt

```text
Analyze the community information provided.

Evaluate:

1. Severity
2. Frequency
3. Potential impact

Assign a risk level:

- Low
- Medium
- High
- Critical

Explain your reasoning.

Community Data:

{{community_data}}
```

---

## Expected Output

```json
{
  "riskLevel": "High",
  "reasoning": "Repeated incidents indicate worsening conditions.",
  "confidenceScore": 0.91
}
```

---

# Recommendation Generation Prompt

## Purpose

Generate practical intervention recommendations.

---

## Prompt

```text
Based on the identified risks,
recommend actions that can reduce impact.

Requirements:

- Practical
- Evidence-based
- Prioritized

Risk Assessment:

{{risk_assessment}}
```

---

## Expected Output

```json
{
  "recommendations": [
    {
      "priority": "High",
      "action": "Coordinate emergency water delivery."
    },
    {
      "priority": "Medium",
      "action": "Conduct infrastructure assessment."
    }
  ]
}
```

---

# Impact Trend Analysis Prompt

## Purpose

Identify trends from project metrics.

---

## Input

```json
{
  "metrics": [
    {
      "month": "January",
      "beneficiaries": 120
    },
    {
      "month": "February",
      "beneficiaries": 180
    }
  ]
}
```

---

## Prompt

```text
Analyze the following impact metrics.

Identify:

- Increasing trends
- Stable trends
- Declining trends

Provide explanations.

Metrics:

{{metrics}}
```

---

## Expected Output

```json
{
  "trendDirection": "Increasing",
  "summary": "Beneficiary reach increased by 50 percent."
}
```

---

# Executive Summary Prompt

## Purpose

Generate summaries for NGO managers and donors.

---

## Prompt

```text
Create a concise executive summary.

Audience:
NGO Program Managers

Include:

- Key findings
- Risks
- Achievements
- Recommended next actions

Data:

{{data}}
```

---

## Expected Output

```json
{
  "summary": "Project outcomes improved while water-related risks increased."
}
```

---

# Research Insight Prompt

## Purpose

Support researchers analyzing community impact.

---

## Prompt

```text
Review the provided reports and metrics.

Identify:

- Significant findings
- Emerging social patterns
- Areas requiring further investigation

Data:

{{research_data}}
```

---

## Expected Output

```json
{
  "insights": [
    "Community participation increased.",
    "Resource shortages remain concentrated in rural regions."
  ]
}
```

---

# Output Schema Standards

All AI outputs should follow:

```json
{
  "summary": "",
  "confidenceScore": 0.0,
  "recommendations": [],
  "generatedAt": ""
}
```

---

# Confidence Score Guidelines

| Score      | Interpretation       |
| ---------- | -------------------- |
| 0.90–1.00  | Very High Confidence |
| 0.75–0.89  | High Confidence      |
| 0.50–0.74  | Moderate Confidence  |
| Below 0.50 | Low Confidence       |

Low confidence results should trigger human review.

---

# AI Safety Guardrails

The model must:

* Avoid harmful recommendations.
* Avoid political persuasion.
* Avoid discrimination.
* Avoid unsupported claims.
* Avoid hallucinated statistics.

The model should explicitly state uncertainty when data is incomplete.

---

# IBM Granite Optimization

Prompts are designed for:

* Granite Instruct Models
* Granite Reasoning Models
* Granite Enterprise Models

Optimization techniques:

* Structured prompting
* JSON output enforcement
* Context grounding
* Evidence-based reasoning
* Confidence scoring

---

# Future Prompt Library

Future versions may include:

## Predictive Risk Forecasting

Predict future community risks.

---

## Geospatial Intelligence

Analyze location-based community patterns.

---

## Community Impact Forecasting

Estimate intervention outcomes.

---

## Conversational AI Assistant

Enable natural-language interaction with DscienTia intelligence services.

---

# Version

AI Prompt Templates v0.1

Milestone:

v0.6 AI Insight MVP

Created: June 2026

Related Documents:

* AI Architecture
* AI Use Cases
* Risk Scoring Model
* IBM WatsonX Integration
* API Contracts
