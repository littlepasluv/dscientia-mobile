# DscienTia Deployment Architecture

## Overview

This document defines the deployment architecture for DscienTia.

The deployment strategy separates the public website, Flutter Web MVP demo, and backend API into dedicated subdomains.

This approach keeps the product clear, secure, and scalable.

## Final Domain Structure

```text
www.dscientia.dev      → public website / landing page
app.dscientia.dev      → Flutter Web MVP demo
api.dscientia.dev      → Laravel API backend
```

## Why This Structure?

DscienTia has three different responsibilities:

1. Public communication
2. Product interaction
3. Backend and AI service integration

These responsibilities should not be mixed into one deployment target.

## Domain Responsibilities

### www.dscientia.dev

Purpose:

```text
Public website
Landing page
Brand credibility
IBM Builder narrative
Contact and product explanation
```

This domain should remain the public face of DscienTia.

Recommended content:

- mission;
- problem statement;
- solution overview;
- AI for community resilience narrative;
- IBM/watsonx direction;
- product screenshots;
- demo link to `app.dscientia.dev`;
- contact information.

This domain should not host the experimental Flutter MVP directly.

---

### app.dscientia.dev

Purpose:

```text
Flutter Web MVP demo
Interactive product experience
Dashboard
Community Risk Report Form
AI Insight Demo
```

This subdomain should host the Flutter Web build output.

Expected build source:

```text
frontend/dscientia_app/build/web
```

Primary user flow:

```text
Open app.dscientia.dev
↓
View DscienTia dashboard
↓
Create community risk report
↓
Generate AI Insight demo
↓
Review summary, priority, suggested action, and ethical note
```

This subdomain is intended for product demonstration.

---

### api.dscientia.dev

Purpose:

```text
Laravel API backend
Authentication
Reports API
AI Insights API
IBM/watsonx integration layer
```

This subdomain should host the backend API.

Planned backend source:

```text
backend/dscientia_api
```

The API will support:

- user authentication;
- community risk report persistence;
- AI insight generation;
- structured AI response;
- secure IBM/watsonx integration;
- future audit-ready workflow.

Flutter should call:

```text
https://api.dscientia.dev/api/v1
```

## High-Level Deployment Flow

```text
User
↓
www.dscientia.dev
↓
Learns about DscienTia
↓
Clicks demo link
↓
app.dscientia.dev
↓
Uses Flutter Web MVP
↓
Flutter calls API
↓
api.dscientia.dev
↓
Laravel processes request
↓
Future IBM/watsonx service layer
```

## AI Integration Flow

The frontend must not call IBM/watsonx directly.

Correct architecture:

```text
Flutter Web
↓
api.dscientia.dev
↓
Laravel AiInsightService
↓
WatsonxAiProvider
↓
IBM/watsonx.ai
```

## Security Principles

Minimum deployment security principles:

- IBM/watsonx credentials must stay in backend environment variables.
- Flutter Web must never contain AI provider secrets.
- API endpoints should use HTTPS.
- Protected endpoints should require authentication.
- CORS should only allow trusted frontend origins.
- `.env` files must never be committed to Git.
- Production API errors should not expose internal stack traces.

## Environment Configuration

### Flutter

Development API base URL:

```text
http://127.0.0.1:8000/api/v1
```

Production API base URL:

```text
https://api.dscientia.dev/api/v1
```

### Laravel

Recommended production values:

```text
APP_ENV=production
APP_DEBUG=false
APP_URL=https://api.dscientia.dev
FRONTEND_URL=https://app.dscientia.dev
```

Future IBM/watsonx values:

```text
WATSONX_API_KEY=
WATSONX_PROJECT_ID=
WATSONX_BASE_URL=https://us-south.ml.cloud.ibm.com
WATSONX_MODEL_ID=
```

These values must only live in backend environment configuration.

## Deployment Phases

### DEPLOY-001 — Flutter Web MVP

Target:

```text
https://app.dscientia.dev
```

Scope:

- build Flutter Web;
- upload static output;
- verify dashboard loads;
- verify AI Insight demo route works;
- keep backend integration mocked or disabled if API is not ready.

### DEPLOY-002 — Laravel API Subdomain

Target:

```text
https://api.dscientia.dev
```

Scope:

- deploy Laravel backend;
- configure document root to Laravel `public` directory;
- configure environment variables;
- verify `/api/health`;
- prepare API versioning.

### DEPLOY-003 — Flutter to API Integration

Target:

```text
app.dscientia.dev → api.dscientia.dev
```

Scope:

- configure Flutter production API base URL;
- enable authenticated requests;
- verify reports API;
- verify AI insight API.

### DEPLOY-004 — IBM/watsonx Backend Integration

Target:

```text
api.dscientia.dev → IBM/watsonx
```

Scope:

- store IBM/watsonx credentials securely;
- implement `WatsonxAiProvider`;
- validate structured JSON output;
- preserve ethical AI note.

## Best Practice Decision

The deployment architecture intentionally separates:

```text
Marketing website
Product application
Backend API
```

This makes DscienTia easier to explain, safer to deploy, and more credible for IBM Builder review.

## Current Recommendation

Do not replace `www.dscientia.dev` with the Flutter app.

The best current path is:

```text
Keep www.dscientia.dev as landing page
Deploy Flutter MVP to app.dscientia.dev
Deploy Laravel API later to api.dscientia.dev
```

## Next Step

The next deployment milestone should be:

```text
DEPLOY-001 — Deploy Flutter Web MVP to app.dscientia.dev
```