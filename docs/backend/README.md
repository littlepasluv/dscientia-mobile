# DscienTia Backend

The DscienTia backend is the Laravel API layer for authentication, community
risk reports, AI insight generation, and the replaceable IBM/watsonx provider
integration.

## Purpose

The backend supports the DscienTia mobile MVP by providing:

- secure user authentication;
- community risk report persistence;
- AI insight generation endpoints;
- structured response validation;
- a replaceable AI provider abstraction;
- an implemented IBM/watsonx integration path;
- audit-ready data flow for community resilience insights.

## Current Status

Current status: implemented and deployed.

The backend currently provides:

- Laravel API foundation;
- authentication endpoints;
- community risk report persistence;
- AI insight generation;
- deterministic mock AI provider;
- IBM/watsonx provider integration behind the same provider contract;
- structured AI insight response handling;
- automated provider and API tests.

Production currently uses the deterministic mock provider through
`DSCIENTIA_AI_PROVIDER=mock`. Controlled live IBM/watsonx verification remains
pending approved IBM Cloud access and the required watsonx project, credentials,
and model availability.

## Backend Stack

```text
Laravel
MySQL
REST API
Token-based authentication
AI provider abstraction
IBM/watsonx integration layer
Structured JSON AI response
```

## Backend Location

The backend lives inside the monorepo under:

```text
backend/dscientia_api
```

This keeps the project organized as:

```text
dscientia-mobile/
├── frontend/
│   └── dscientia_app/
├── backend/
│   └── dscientia_api/
└── docs/
```

## Core Backend Modules

The implemented backend includes:

```text
Authentication
Reports
AI Insights
Users
Audit / Logs
```

## Backend MVP Scope

The implemented backend focuses on the API capabilities required for the
DscienTia MVP and IBM Builder submission.

### In Scope

```text
POST /api/v1/auth/login
POST /api/v1/auth/register
GET  /api/v1/auth/session
POST /api/v1/auth/logout

POST /api/v1/reports
GET  /api/v1/reports
GET  /api/v1/reports/{id}

POST /api/v1/ai/insights
GET  /api/v1/ai/insights/{id}
```

### Out of Scope for Initial MVP

```text
role management
admin dashboard
advanced analytics
organization/team management
multi-region deployment
real-time notifications
payment/subscription
advanced moderation workflow
```

## Backend Responsibility

The backend is responsible for:

- receiving Flutter API requests;
- validating input;
- storing reports;
- preparing AI insight prompts;
- calling AI service providers;
- validating AI output;
- returning structured responses to Flutter.

The backend should not expose IBM/watsonx credentials to Flutter.

## Flutter Responsibility

Flutter is responsible for:

- collecting user input;
- displaying report forms;
- displaying AI insight results;
- storing authentication tokens securely;
- sending authenticated API requests.

Flutter should not call IBM/watsonx directly.

## AI Integration Direction

The backend should isolate AI generation behind a service layer.

Initial service path:

```text
AiInsightController
↓
AiInsightService
↓
MockAiProvider
↓
Structured AiInsight response
```

Future service path:

```text
AiInsightController
↓
AiInsightService
↓
WatsonxAiProvider
↓
Structured AiInsight response
```

## Related Documents

- [Reports and AI Insights Backend Architecture](Reports-and-AI-Insights-Architecture.md)
- [Reports + AI Backend Architecture Baseline v1.0](../reviews/backend/Reports-AI-Backend-Architecture-Baseline-v1.0.md)
- [AI Insight Feature](../features/ai-insight/README.md)