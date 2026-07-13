# DscienTia Backend

This directory contains the backend foundation for DscienTia.

The backend is a Laravel API application that supports:

- community risk reports;
- mock AI insight generation;
- future IBM/watsonx integration through a service contract.

## Application Location

```text
backend/dscientia_api
```

## Current Backend Status

Completed milestones:

```text
MVP-007 — Laravel Backend Foundation
MVP-008 — Reports API
MVP-009 — AI Insight Mock API
MVP-010 — IBM/watsonx Integration Contract
```

## Implemented API Endpoints

```text
GET  /api/health
GET  /api/reports
POST /api/reports
GET  /api/reports/{report}
POST /api/ai-insights
GET  /api/ai-insights/{aiInsight}
```

## Local Development

From the Laravel app directory:

```bash
cd backend/dscientia_api
php artisan serve --host=127.0.0.1 --port=8000
```

Health check:

```bash
curl http://127.0.0.1:8000/api/health
```

Run tests:

```bash
php artisan test
```

## AI Provider Configuration

The backend currently uses the mock provider:

```text
DSCIENTIA_AI_PROVIDER=mock
```

Future IBM/watsonx configuration keys:

```text
WATSONX_API_KEY=
WATSONX_PROJECT_ID=
WATSONX_BASE_URL=https://us-south.ml.cloud.ibm.com
WATSONX_MODEL_ID=ibm/granite-3-8b-instruct
```

Credentials must only be stored in backend environment variables.

## Next Backend Milestones

```text
MVP-011 — Backend API manual testing and Flutter integration preparation
DEPLOY-002 — Prepare api.dscientia.dev
MVP-012 — Real IBM/watsonx API integration
```
