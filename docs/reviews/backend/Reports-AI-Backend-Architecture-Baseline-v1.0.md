# Reports + AI Backend Architecture Baseline v1.0

## Review Status

Status: Accepted as backend architecture baseline

Date: 2026-07-09

Scope:

```text
Laravel backend planning
Reports API
AI Insights API
Mock AI provider
Future IBM/watsonx provider
Flutter integration path
```

## Baseline Summary

This baseline defines the initial backend architecture for DscienTia Reports and AI Insights.

The backend will support:

- report persistence;
- authenticated access;
- AI insight generation;
- mock AI provider for MVP demo;
- future IBM/watsonx provider integration;
- structured JSON response for Flutter.

## Accepted Backend Location

The backend should be created under:

```text
backend/dscientia_api
```

Accepted monorepo structure:

```text
dscientia-mobile/
├── frontend/
│   └── dscientia_app/
├── backend/
│   └── dscientia_api/
└── docs/
```

## Accepted MVP Backend Modules

```text
Authentication
Reports
AI Insights
Users
Basic API response support
```

## Accepted Initial API Scope

### Authentication

```text
POST /api/v1/auth/register
POST /api/v1/auth/login
GET  /api/v1/auth/session
POST /api/v1/auth/logout
```

### Reports

```text
POST /api/v1/reports
GET  /api/v1/reports
GET  /api/v1/reports/{id}
```

### AI Insights

```text
POST /api/v1/ai/insights
GET  /api/v1/ai/insights/{id}
```

## Accepted Report Fields

```text
id
user_id
title
category
location
description
urgency
status
created_at
updated_at
```

## Accepted AI Insight Fields

```text
id
report_id
summary
priority_label
priority_rationale
suggested_action
action_steps
ethical_note
provider
model_name
created_at
updated_at
```

## Accepted AI Provider Architecture

The backend should use a replaceable provider architecture:

```text
AiInsightController
↓
AiInsightService
↓
AiProviderInterface
↓
MockAiProvider / WatsonxAiProvider
```

## Accepted MVP Provider

Initial provider:

```text
MockAiProvider
```

Reason:

- enables backend demo without IBM credentials;
- provides deterministic output;
- reduces integration risk;
- allows Flutter backend connection earlier;
- preserves the future path to IBM/watsonx.

## Accepted Future Provider

Future provider:

```text
WatsonxAiProvider
```

Reason:

- supports IBM/watsonx integration;
- aligns with the IBM Builder direction;
- allows structured AI insight generation;
- keeps Flutter independent from AI provider details.

## Accepted Response Contract

The backend AI Insight response must provide structured JSON:

```json
{
  "data": {
    "summary": "Short risk summary.",
    "priority_label": "High Priority",
    "priority_rationale": "Reasoning behind the priority.",
    "suggested_action": "Recommended action.",
    "action_steps": [
      "Step 1",
      "Step 2",
      "Step 3"
    ],
    "ethical_note": "AI output should be verified by humans.",
    "provider": "mock",
    "model_name": "mock-resilience-insight-v1"
  }
}
```

## Security Assessment

Minimum accepted security requirements:

- protected report endpoints;
- protected AI insight endpoints;
- token-based API access;
- backend-only storage for IBM/watsonx credentials;
- user ownership checks for reports and insights;
- validated input before report creation and AI generation.

## Ethical AI Assessment

The backend must preserve an ethical AI note in every generated insight.

The AI output must be positioned as decision support, not final authority.

Accepted ethical constraints:

- local verification required;
- no sensitive personal data exposure;
- no automatic high-impact decision-making;
- human responsibility remains central;
- recommendations must remain practical and contextual.

## Accepted MVP Limitations

The following limitations are accepted for baseline v1.0:

- no real IBM/watsonx call yet;
- no advanced moderation;
- no admin dashboard;
- no real-time notification;
- no confidence score;
- no audit log;
- no multilingual output;
- no analytics module.

These are acceptable because the immediate goal is a working IBM-ready MVP slice.

## IBM Builder Readiness Impact

This backend architecture improves IBM Builder readiness because it defines:

- where IBM/watsonx will be integrated;
- how AI output will be structured;
- how Flutter will consume AI insights;
- how mock AI can evolve into IBM/watsonx AI;
- how ethical AI output is preserved.

Current readiness after this baseline:

```text
Visible Flutter MVP flow      : yes
Backend architecture          : yes
Mock AI provider direction    : yes
IBM/watsonx path              : defined
Backend implementation        : not yet
Formal submission readiness   : not yet
```

## Decision

Reports + AI Backend Architecture Baseline v1.0 is accepted.

The next milestone should create the Laravel backend foundation without overbuilding features outside the MVP scope.

## Next Recommended Milestone

```text
MVP-007 — Laravel Backend Foundation
```