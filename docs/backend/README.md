# DscienTia Backend

The DscienTia backend will provide the API foundation for authentication, community risk reports, AI insight generation, and future IBM/watsonx integration.

The backend is planned to use Laravel as the main API framework.

## Purpose

The backend exists to support the DscienTia mobile MVP by providing:

- secure user authentication;
- community risk report persistence;
- AI insight generation endpoints;
- structured response validation;
- future IBM/watsonx integration;
- audit-ready data flow for community resilience insights.

## Current Status

Current status: architecture planning.

At this stage, the Flutter MVP already supports:

- authentication foundation;
- dashboard skeleton;
- community risk report form;
- mock AI insight generator;
- AI insight result screen.

The backend has not been implemented yet.

## Planned Backend Stack

```text
Laravel
PostgreSQL
REST API
Token-based authentication
IBM/watsonx integration layer
Structured JSON AI response
```

## Planned Backend Location

The backend should live inside the monorepo under:

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

The first backend MVP should include:

```text
Authentication
Reports
AI Insights
Users
Audit / Logs
```

## MVP Backend Scope

The first backend implementation should focus only on what is required for the IBM Builder MVP.

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