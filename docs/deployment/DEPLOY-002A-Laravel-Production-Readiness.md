# DEPLOY-002A — Laravel Production Readiness

## Status

Prepared locally.

## Purpose

This milestone prepares the DscienTia Laravel backend for future deployment to:

    https://api.dscientia.dev

This step does not deploy the backend yet.

## Target Architecture

    www.dscientia.dev  → public landing page
    app.dscientia.dev  → Flutter Web MVP
    api.dscientia.dev  → Laravel API backend

## Prepared Files

Production environment example:

    backend/dscientia_api/.env.production.example

CORS configuration:

    backend/dscientia_api/config/cors.php

CORS test:

    backend/dscientia_api/tests/Unit/CorsConfigurationTest.php

## Production Environment Rules

The real production `.env` file must never be committed.

The production server should use:

    APP_ENV=production
    APP_DEBUG=false
    APP_URL=https://api.dscientia.dev

## Database Decision

For local development, SQLite is acceptable.

For production deployment, the backend should use MySQL on Hostinger:

    DB_CONNECTION=mysql

The production database credentials must only be stored in the server `.env`.

## CORS Decision

The API should allow requests from:

    https://app.dscientia.dev
    https://www.dscientia.dev

Local development origins are also allowed in the default local config.

Production can narrow this using:

    DSCIENTIA_CORS_ALLOWED_ORIGINS

## AI Provider Decision

For DEPLOY-002A, the API still uses:

    DSCIENTIA_AI_PROVIDER=mock

IBM/watsonx credentials are not enabled yet.

## Security Rules

Do not commit:

    .env
    database/database.sqlite
    vendor/
    node_modules/
    IBM/watsonx credentials
    production database credentials

## Verification Commands

From the Laravel app directory:

    cd backend/dscientia_api
    php artisan config:clear
    php artisan test

Expected result:

    All tests pass

## Next Milestone

    DEPLOY-002B — Prepare Hostinger api.dscientia.dev website and database
