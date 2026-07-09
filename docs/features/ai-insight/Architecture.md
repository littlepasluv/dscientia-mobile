# AI Insight Architecture

## Overview

AI Insight is the first product-defining MVP feature of DscienTia.

The feature demonstrates how DscienTia can convert community risk reports into structured, explainable, and ethically guided resilience insights.

The current implementation is intentionally lightweight and local-first. It uses a mock generator to validate the user experience before backend and IBM/watsonx integration.

## Strategic Role in the MVP

AI Insight is not a secondary feature.

It is the central capability that makes DscienTia more than a reporting tool.

Without AI Insight, DscienTia is mainly a data collection app. With AI Insight, DscienTia becomes a decision-support platform for community resilience.

## Current MVP Flow

```text
Dashboard
↓
Community Risk Report Form
↓
CommunityRiskReportDraft
↓
MockAiInsightGenerator
↓
AiInsight
↓
AI Insight Result Screen
```

## Current User Flow

1. User opens the DscienTia dashboard.
2. User selects either:
    - Start AI Insight Flow; or
    - Create Risk Report.
3. User submits a community risk report.
4. App creates a `CommunityRiskReportDraft`.
5. App passes the draft to the AI Insight result route.
6. The mock generator creates an `AiInsight`.
7. The result screen displays the structured insight.

## Domain Objects

### CommunityRiskReportDraft

Location:

```text
frontend/dscientia_app/lib/features/reports/domain/entities/community_risk_report_draft.dart
```

Purpose:

Represents the temporary community risk report submitted by the user.

Fields:

```text
title
category
location
description
urgency
```

This object is intentionally simple because backend persistence has not been added yet.

### AiInsight

Location:

```text
frontend/dscientia_app/lib/features/ai_insight/domain/entities/ai_insight.dart
```

Purpose:

Represents the structured output of the AI Insight process.

Fields:

```text
summary
priorityLabel
priorityRationale
suggestedAction
actionSteps
ethicalNote
```

This structure is designed to map cleanly to a future JSON response from the backend AI service.

## Mock Generator

Location:

```text
frontend/dscientia_app/lib/features/ai_insight/domain/services/mock_ai_insight_generator.dart
```

Current responsibility:

```text
CommunityRiskReportDraft
↓
MockAiInsightGenerator
↓
AiInsight
```

The generator currently uses deterministic local logic based on:

```text
category
urgency
location
description
```

It does not call an external API.

## Why Mock First?

The mock generator exists for three reasons:

1. Validate the product flow before backend development.
2. Allow UI and demo work to continue without waiting for IBM/watsonx credentials.
3. Define the structured response expected from the future AI service.

This is a deliberate MVP strategy.

## Future Backend Flow

The future backend-powered flow will be:

```text
Flutter Report Form
↓
POST /reports
↓
POST /ai/insights
↓
Laravel AI Insight Service
↓
IBM watsonx.ai
↓
Structured JSON response
↓
Flutter AI Insight Result Screen
```

## Future API Contract Direction

The backend AI Insight endpoint should return a structured JSON response similar to:

```json
{
  "summary": "Short explanation of the reported community risk.",
  "priority_label": "High Priority",
  "priority_rationale": "Reasoning behind the priority level.",
  "suggested_action": "Main recommended community action.",
  "action_steps": [
    "Document the issue.",
    "Notify local leaders.",
    "Prepare response plan."
  ],
  "ethical_note": "This insight supports decision-making and should be verified locally."
}
```

## IBM/watsonx Integration Direction

The future IBM/watsonx integration should follow this responsibility split:

```text
Flutter
- collects report input
- displays insight result
- does not directly call watsonx

Laravel Backend
- receives report data
- prepares structured prompt
- calls IBM/watsonx
- validates AI response
- stores insight result

IBM watsonx.ai
- generates structured resilience insight
- supports explainable, controlled, and governed AI output
```

## Ethical AI Requirements

Every AI Insight output must include an ethical note.

The ethical note exists because community resilience decisions may affect real people and local communities.

Minimum ethical constraints:

- AI output must not be treated as final authority.
- Local verification is required.
- Sensitive personal data should not be exposed.
- Recommendations should be practical and context-aware.
- The system should support human decision-making, not replace it.

## MVP Limitations

Current limitations:

- no backend persistence;
- no real AI API call;
- no IBM/watsonx integration yet;
- no user-specific report history;
- no generated insight storage;
- no audit log;
- no confidence score;
- no multilingual output.

These limitations are acceptable for the current MVP stage because the goal is to validate the product flow first.

## Next Steps

Planned next steps:

```text
MVP-006
Backend architecture for reports and AI insights

MVP-007
Laravel reports API

MVP-008
Laravel AI insight mock API

MVP-009
IBM/watsonx integration contract

MVP-010
Structured prompt and response validation
```

## Design Decision

The current mock implementation should not be removed until the backend integration is stable.

It should remain useful for:

- offline demo mode;
- UI testing;
- fallback demo;
- local development;
- future automated tests.