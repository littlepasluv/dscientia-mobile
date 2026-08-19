# DscienTia Deployment

This directory documents the deployment architecture for DscienTia.

The deployment strategy separates the public website, product demo application, and backend API into different subdomains.

## Deployment Domains

```text
www.dscientia.dev
Landing page and public website

app.dscientia.dev
Flutter Web MVP demo

api.dscientia.dev
Laravel API backend
```

## Purpose

The purpose of this deployment separation is to keep DscienTia organized as a real product ecosystem.

Each subdomain has a clear responsibility:

- `www.dscientia.dev` explains the mission, product story, and credibility.
- `app.dscientia.dev` provides a live product demo.
- `api.dscientia.dev` handles backend logic, authentication, reports, AI insights, and the implemented IBM/watsonx provider integration boundary.

## Current Status

Current deployment status:

```text
www.dscientia.dev  : live landing page
app.dscientia.dev  : live Flutter Web MVP
api.dscientia.dev  : live Laravel API
```

## Strategic Direction

DscienTia should not expose IBM/watsonx credentials in the frontend.

The correct flow is:

```text
Flutter Web App
↓
Laravel API Backend
↓
AI Provider Contract
├── Deterministic Mock Provider (production)
└── IBM/watsonx Provider (implemented, pending controlled live verification)
```

## Deployment Sequence

Recommended deployment order:

```text
DEPLOY-001
Deploy Flutter Web MVP to app.dscientia.dev — completed

DEPLOY-002
Prepare api.dscientia.dev for Laravel backend — completed

DEPLOY-003
Connect Flutter Web MVP to Laravel API — completed

IBM/watsonx provider integration
Implemented at the backend application boundary; controlled live verification
is tracked under MVP-015E.

Production remains on the deterministic mock provider until live IBM
verification succeeds.
```

## Related Documents

- [Deployment Architecture](Deployment-Architecture.md)
- [ADR-005 Deployment Architecture](../adr/ADR-005-Deployment-Architecture.md)