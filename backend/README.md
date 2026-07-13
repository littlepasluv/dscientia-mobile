# DscienTia Backend

This directory contains the backend foundation for DscienTia.

The backend is planned as a Laravel API application that will support:

- authentication;
- community risk reports;
- AI insight generation;
- future IBM/watsonx integration.

## Application Location

```text
backend/dscientia_api
```

## Current MVP Status

Current milestone:

```text
MVP-007 — Laravel Backend Foundation
```

Implemented foundation:

```text
Laravel application
API route support
GET /api/health endpoint
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

Expected response:

```json
{
  "data": {
    "status": "ok",
    "service": "dscientia-api",
    "version": "0.1.0"
  }
}
```

## Next Backend Milestones

```text
MVP-008 — Reports API
MVP-009 — AI Insight Mock API
MVP-010 — IBM/watsonx Integration Contract
DEPLOY-002 — Prepare api.dscientia.dev
```