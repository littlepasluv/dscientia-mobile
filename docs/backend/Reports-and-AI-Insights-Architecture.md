# Reports and AI Insights Backend Architecture

## Overview

This document defines the implemented backend architecture for DscienTia reports and AI insights.

The backend serves as the bridge between the Flutter mobile app, persistent report data, AI insight generation, and the implemented IBM/watsonx provider integration boundary.

The goal is to support an IBM Builder-ready MVP without overbuilding the backend too early.

## Strategic Role

The backend is critical because DscienTia should not remain only a local Flutter demo.

The backend enables:

- persistent community risk reports;
- authenticated API access;
- AI insight generation;
- implemented IBM/watsonx provider integration boundary;
- audit-ready decision-support workflow.

## Backend Structure

Target location:

```text
backend/dscientia_api
```

Recommended Laravel structure:

```text
app/
├── Http/
│   ├── Controllers/
│   │   ├── AuthController.php
│   │   ├── ReportController.php
│   │   └── AiInsightController.php
│   └── Requests/
│       ├── StoreReportRequest.php
│       └── GenerateAiInsightRequest.php
│
├── Models/
│   ├── User.php
│   ├── Report.php
│   └── AiInsight.php
│
├── Services/
│   └── AiInsight/
│       ├── AiInsightService.php
│       ├── AiProviderInterface.php
│       ├── MockAiProvider.php
│       └── WatsonxAiProvider.php
│
└── Support/
    └── ApiResponse.php
```

## Main Backend Flow

```text
Flutter Mobile App
↓
Laravel REST API
↓
Validation Layer
↓
Report Model / AiInsight Model
↓
AiInsightService
↓
Mock Provider or IBM/watsonx Provider
↓
Structured JSON Response
↓
Flutter AI Insight Result Screen
```

## Reports Module

### Purpose

The Reports module stores community risk reports submitted by users.

A report represents a local issue such as:

- flooding;
- public safety;
- health risk;
- infrastructure issue;
- environment issue;
- community needs;
- other local risk.

### Planned Report Fields

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

### Suggested Status Values

```text
draft
submitted
analyzed
resolved
archived
```

For MVP, the most important values are:

```text
submitted
analyzed
```

## AI Insights Module

### Purpose

The AI Insights module generates and stores structured insight outputs from community risk reports.

An AI insight should help users understand:

- what the risk means;
- how urgent it is;
- what action may be useful;
- what ethical caution should be considered.

### Planned AI Insight Fields

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

### Provider Values

Initial MVP:

```text
mock
```

Future:

```text
watsonx
```

## API Endpoints

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

## Report Create Request

Endpoint:

```text
POST /api/v1/reports
```

Request body:

```json
{
  "title": "Flooding near community road",
  "category": "Flooding",
  "location": "RT 07 RW 01, Magelang",
  "description": "Residents reported recurring flooding near the main community road after heavy rain.",
  "urgency": "High"
}
```

Response body:

```json
{
  "data": {
    "id": "report_001",
    "title": "Flooding near community road",
    "category": "Flooding",
    "location": "RT 07 RW 01, Magelang",
    "description": "Residents reported recurring flooding near the main community road after heavy rain.",
    "urgency": "High",
    "status": "submitted",
    "created_at": "2026-07-09T12:00:00Z"
  }
}
```

## AI Insight Generate Request

Endpoint:

```text
POST /api/v1/ai/insights
```

Request body:

```json
{
  "report_id": "report_001"
}
```

Alternative MVP request body before report persistence is fully stable:

```json
{
  "report": {
    "title": "Flooding near community road",
    "category": "Flooding",
    "location": "RT 07 RW 01, Magelang",
    "description": "Residents reported recurring flooding near the main community road after heavy rain.",
    "urgency": "High"
  }
}
```

## AI Insight Generate Response

Response body:

```json
{
  "data": {
    "id": "insight_001",
    "report_id": "report_001",
    "summary": "The report describes a recurring flooding issue affecting local mobility and safety.",
    "priority_label": "High Priority",
    "priority_rationale": "The issue is marked as high urgency and may affect access to essential services.",
    "suggested_action": "Prioritize drainage inspection, mobility safety, and local coordination.",
    "action_steps": [
      "Document affected road segments and water depth.",
      "Identify blocked drainage points.",
      "Notify local community leaders.",
      "Prepare a short-term mobility and safety plan."
    ],
    "ethical_note": "This AI insight is a decision-support summary, not a final authority. Local verification is required.",
    "provider": "mock",
    "model_name": "mock-resilience-insight-v1",
    "created_at": "2026-07-09T12:05:00Z"
  }
}
```

## AI Service Layer

The AI logic should be isolated behind a service boundary.

Recommended structure:

```text
AiInsightController
↓
AiInsightService
↓
AiProviderInterface
↓
MockAiProvider / WatsonxAiProvider
```

## AiProviderInterface Responsibility

The provider interface should define one responsibility:

```text
Generate a structured AI insight from a report payload.
```

The provider should return structured data, not free-form text only.

## Mock AI Provider

The mock provider should exist first.

Purpose:

- support offline demo;
- support development without IBM credentials;
- validate Flutter integration;
- provide deterministic test output;
- reduce risk before external AI integration.

## IBM/watsonx Provider

The IBM/watsonx provider integration boundary is implemented behind the same
provider contract as the mock provider. It is covered by automated tests and
remains disabled in production until controlled live IBM verification is
completed.

Responsibilities:

- prepare structured prompt;
- call IBM/watsonx.ai;
- parse AI output;
- validate response structure;
- fallback safely if response is incomplete.

Flutter should not know whether the insight comes from mock provider or watsonx provider.

## Security Requirements

Minimum backend security requirements:

- authentication required for reports and AI insight endpoints;
- user can only access their own reports;
- access token required for protected routes;
- IBM/watsonx credentials stored only in backend environment variables;
- no secrets returned to Flutter;
- input validation required for all report fields.

## Ethical AI Requirements

Every AI insight must include:

```text
ethical_note
```

The ethical note is required because DscienTia supports decisions that may affect real communities.

Minimum ethical requirements:

- AI output must support, not replace, human decision-making;
- local verification must be required;
- sensitive personal data should not be exposed;
- recommendation should be practical and context-aware;
- community leaders remain responsible for final decisions.

## MVP Limitations

Accepted MVP limitations:

- no advanced role management;
- no full moderation workflow;
- no real-time alerts;
- no analytics dashboard;
- no multilingual AI output;
- no confidence score;
- no audit log in first backend iteration.

These limitations are acceptable because the immediate goal is to create a working IBM-ready MVP slice.

## Backend Milestone Plan

```text
MVP-007
Create Laravel backend foundation

MVP-008
Implement Reports API

MVP-009
Implement AI Insight Mock API

MVP-010
Define IBM/watsonx integration contract

MVP-011
Connect Flutter to backend AI Insight API

MVP-015B–MVP-015D
Implement and test the IBM/watsonx provider, response mapping, retry policy,
safe fallback, logging, and error sanitization

MVP-015E
Perform controlled live IBM watsonx verification
```

## Architecture Decision

The backend should be built around a replaceable AI provider architecture.

This means the mock provider and IBM/watsonx provider must share the same output contract.

Accepted direction:

```text
MockAiProvider output
=
WatsonxAiProvider output
=
AiInsight structured JSON response
```

This keeps the Flutter app stable while the backend AI provider evolves.

Production currently uses the deterministic mock provider through
`DSCIENTIA_AI_PROVIDER=mock`; IBM/watsonx activation remains pending controlled
live verification.