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
- `api.dscientia.dev` handles backend logic, authentication, reports, AI insights, and future IBM/watsonx integration.

## Current Status

Current deployment status:

```text
www.dscientia.dev  : existing landing page
app.dscientia.dev  : planned Flutter Web MVP deployment
api.dscientia.dev  : planned Laravel API deployment
```

## Strategic Direction

DscienTia should not expose IBM/watsonx credentials in the frontend.

The correct flow is:

```text
Flutter Web App
↓
Laravel API Backend
↓
IBM/watsonx Service Layer
```

## Deployment Sequence

Recommended deployment order:

```text
DEPLOY-001
Deploy Flutter Web MVP to app.dscientia.dev

DEPLOY-002
Prepare api.dscientia.dev for Laravel backend

DEPLOY-003
Connect Flutter Web MVP to Laravel API

DEPLOY-004
Add IBM/watsonx backend integration
```

## Related Documents

- [Deployment Architecture](Deployment-Architecture.md)
- [ADR-005 Deployment Architecture](../adr/ADR-005-Deployment-Architecture.md)