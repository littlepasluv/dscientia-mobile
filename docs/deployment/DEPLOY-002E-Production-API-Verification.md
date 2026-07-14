# DEPLOY-002E — Production API Migration and Verification

## Status

Completed.

## Purpose

This milestone verifies that the DscienTia Laravel API is deployed, migrated, and working in production at:

    https://api.dscientia.dev

## Production API Base URL

    https://api.dscientia.dev/api

## Verified Endpoints

    GET  /api/health
    POST /api/reports
    POST /api/ai-insights

## Migration Result

Production database migrations were executed successfully on Hostinger using PHP 8.4.

The production database now supports:

    users
    cache
    jobs
    personal_access_tokens
    community_risk_reports
    ai_insights

## PHP CLI Note

The default Hostinger terminal PHP was PHP 8.2, while the deployed Laravel dependencies require PHP 8.4.

Production Artisan commands should use:

    /opt/alt/php84/usr/bin/php artisan ...

## Health Check Result

Request:

    GET https://api.dscientia.dev/api/health

Result:

    status: ok
    service: dscientia-api
    version: 0.1.0

## Report Creation Result

Request:

    POST https://api.dscientia.dev/api/reports

Result:

    report_id: 1
    organization_name: Razy Zone International
    status: open

## AI Insight Generation Result

Request:

    POST https://api.dscientia.dev/api/ai-insights

Result:

    ai_insight_id: 1
    report_id: 1
    risk_level: elevated
    model_provider: mock
    model_name: dscientia-local-mock-v0.1
    status: completed

## Current Production AI Provider

    DSCIENTIA_AI_PROVIDER=mock

IBM/watsonx credentials are not enabled yet.

## Security Notes

The production `.env` file is stored only on Hostinger and is not committed.

Do not commit or expose:

    APP_KEY
    DB_PASSWORD
    WATSONX_API_KEY
    production .env

## Next Milestone

    DEPLOY-003 — Build and deploy Flutter Web with production backend mode
