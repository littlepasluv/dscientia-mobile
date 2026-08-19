# ADR-005: Deployment Architecture

## Status

Accepted

## Date

2026-07-10

## Context

DscienTia is evolving from a local Flutter MVP into a product ecosystem intended for IBM Builder readiness.

The project needs a deployment structure that supports:

- public product communication;
- live MVP demonstration;
- backend API development;
- implemented IBM/watsonx provider integration boundary and controlled live verification;
- secure handling of AI provider credentials.

Using a single domain for everything would make the system harder to explain, harder to secure, and harder to scale.

## Decision

DscienTia will use separate subdomains for the public website, product app, and backend API.

Accepted structure:

```text
www.dscientia.dev      → public website / landing page
app.dscientia.dev      → Flutter Web MVP demo
api.dscientia.dev      → Laravel API backend
```

## Responsibilities

### www.dscientia.dev

Responsible for:

- public landing page;
- mission and vision;
- product story;
- IBM Builder narrative;
- contact information;
- links to demo and documentation.

### app.dscientia.dev

Responsible for:

- Flutter Web MVP;
- dashboard;
- community risk report form;
- AI Insight demo;
- product experience.

### api.dscientia.dev

Responsible for:

- Laravel API;
- authentication;
- reports;
- AI insights;
- backend service layer;
- implemented IBM/watsonx provider integration boundary.

## AI Security Decision

Flutter must not call IBM/watsonx directly.

Accepted AI integration path:

```text
Flutter Web
↓
Laravel API
↓
AI Provider Contract
├── Deterministic Mock Provider (production)
└── IBM/watsonx Provider (implemented, pending controlled live verification)
```

IBM/watsonx credentials must be stored only in backend environment variables.

## Consequences

### Positive Consequences

- Clear separation between website, app, and API.
- Safer handling of API credentials.
- Easier production deployment.
- Easier IBM Builder explanation.
- Easier future scaling.
- Cleaner DNS and infrastructure planning.

### Trade-Offs

- Requires subdomain configuration.
- Requires separate deployment process for app and API.
- Requires CORS configuration between `app.dscientia.dev` and `api.dscientia.dev`.
- Requires clearer environment management.

## Deployment Sequence

Accepted deployment order:

```text
1. Keep www.dscientia.dev as public landing page.
2. Deploy Flutter Web MVP to app.dscientia.dev.
3. Deploy Laravel API to api.dscientia.dev.
4. Connect Flutter production API base URL to api.dscientia.dev.
5. Add IBM/watsonx integration through backend service layer.
```

## Alternatives Considered

### Alternative 1: Deploy Flutter app to www.dscientia.dev

Rejected.

Reason:

The public website should remain focused on product story, credibility, and IBM Builder narrative. Replacing it with the app would weaken the public-facing explanation of DscienTia.

### Alternative 2: Deploy Laravel API under www.dscientia.dev/api

Rejected for MVP stage.

Reason:

It mixes public website and backend concerns. A dedicated API subdomain is clearer and more scalable.

### Alternative 3: Flutter directly calls IBM/watsonx

Rejected.

Reason:

Frontend applications must not expose AI provider credentials. The backend must control AI service access.

## Related Documents

- [Deployment Architecture](../deployment/Deployment-Architecture.md)
- [Deployment README](../deployment/README.md)
- [AI Insight Architecture](../features/ai-insight/Architecture.md)
- [Reports and AI Insights Backend Architecture](../backend/Reports-and-AI-Insights-Architecture.md)