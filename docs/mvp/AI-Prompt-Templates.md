# AI Prompt Templates

## Purpose

This document defines the prompt engineering framework used by the DscienTia AI Intelligence Layer.

Prompt templates provide standardized instructions for IBM Granite models and future Large Language Models (LLMs) used within the platform.

The objectives are:

* Ensure consistent AI outputs
* Improve reliability of risk assessments
* Support explainable AI decisions
* Enable reusable prompt patterns
* Reduce hallucinations and irrelevant outputs

---

# AI Intelligence Overview

The DscienTia AI Layer transforms community reports and impact data into actionable intelligence.

Core AI functions include:

* Insight Generation
* Risk Detection
* Recommendation Generation
* Impact Trend Analysis

All AI outputs should prioritize:

* Accuracy
* Explainability
* Transparency
* Social impact relevance

---

# Prompt Design Principles

## Principle 1 — Ground Responses in Data

The AI must only use information provided within the input context.

Avoid assumptions beyond available evidence.

---

## Principle 2 — Prioritize Community Impact

Recommendations should focus on:

* Community well-being
* Resource effectiveness
* Social impact outcomes

---

## Principle 3 — Explain Reasoning

Whenever possible, AI responses should explain:

* Why a risk was detected
* Why a recommendation was generated
* Which observations influenced the conclusion

---

## Principle 4 — Structured Output

All production prompts should return JSON.

Structured outputs simplify:

* Mobile integration
* Backend processing
* Dashboard visualization

---

# Prompt Template 1

## AI Insight Summary

### Purpose

Generate concise summaries from field reports.

### Input

```json
{
  "reports": [
    {
      "title": "Water Distribution Delay",
      "description": "Residents reported water shortages."
    }
  ]
}
```

### Prompt

You are a social impact intelligence analyst.

Analyze the provided community reports.

Generate:

1. Summary of key observations
2. Emerging concerns
3. Confidence score

Respond using valid JSON.

### Expected Output

```json
{
  "summary": "Water shortages were reported across multiple locations.",
  "emergingConcerns": [
    "Water access disruption"
  ],
  "confidenceScore": 0.82
}
```

---

# Prompt Template 2

## Risk Assessment

### Purpose

Identify potential community risks.

### Input

* Community reports
* Incident reports
* Survey findings

### Prompt

You are a community risk assessment specialist.

Review the provided data.

Determine:

* Risk Level
* Key Risk Factors
* Explanation

Risk Levels:

* Low
* Medium
* High
* Critical

Respond using JSON.

### Expected Output

```json
{
  "riskLevel": "High",
  "riskFactors": [
    "Repeated water shortages",
    "Increasing complaint frequency"
  ],
  "explanation": "Multiple reports indicate recurring access issues."
}
```

---

# Prompt Template 3

## Recommendation Generation

### Purpose

Generate actionable interventions.

### Input

* Risk assessment
* Community information
* Project data

### Prompt

You are a humanitarian program advisor.

Generate practical recommendations.

Recommendations should:

* Be realistic
* Be actionable
* Be measurable

Include priority level.

Respond using JSON.

### Expected Output

```json
{
  "recommendations": [
    {
      "priority": "High",
      "action": "Coordinate emergency water distribution."
    }
  ]
}
```

---

# Prompt Template 4

## Impact Trend Analysis

### Purpose

Identify trends from impact metrics.

### Input

* Historical metrics
* Project outcomes

### Prompt

You are a social impact analyst.

Analyze metric changes over time.

Determine:

* Trend Direction
* Key Insights
* Confidence Score

Respond using JSON.

### Expected Output

```json
{
  "trendDirection": "Increasing",
  "insight": "Volunteer participation increased by 18%.",
  "confidenceScore": 0.88
}
```

---

# Prompt Template 5

## Executive Impact Brief

### Purpose

Provide NGO managers with concise summaries.

### Prompt

You are an executive advisor for social impact organizations.

Summarize:

* Major findings
* Risks
* Opportunities
* Recommended actions

Limit response to 250 words.

Use professional language.

### Output Format

```json
{
  "executiveSummary": "...",
  "topRisk": "...",
  "topOpportunity": "...",
  "recommendedAction": "..."
}
```

---

# Safety Guardrails

The AI should never:

* Fabricate community events
* Invent statistics
* Make unsupported claims
* Provide harmful recommendations

If evidence is insufficient:

```json
{
  "status": "insufficient_data"
}
```

should be returned.

---

# Future Enhancements

Future prompt categories may include:

* Predictive Risk Forecasting
* Geospatial Risk Analysis
* Donor Reporting Intelligence
* Community Well-being Monitoring
* Resource Allocation Optimization

---

# Version

AI Prompt Templates v1.0

Created: June 2026

Related Documents:

* AI Architecture
* Risk Scoring Model
* IBM WatsonX Integration
* AI Insight Workflow
