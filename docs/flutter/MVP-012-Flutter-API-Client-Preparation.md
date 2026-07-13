# MVP-012 — Flutter API Client Preparation

## Status

Completed locally.

## Purpose

This milestone prepares the Flutter application to communicate with the Laravel backend API.

The live Flutter Web demo remains safe because this milestone only adds API configuration, DTOs, and API client classes. It does not replace the current public demo flow.

## Backend API Base URL

Local default:

    http://127.0.0.1:8000/api

Build-time override:

    --dart-define=DSCIENTIA_API_BASE_URL=https://api.dscientia.dev/api

## Added Flutter Components

API configuration:

    lib/config/env/dscientia_api_config.dart

Dio provider:

    lib/core/network/dscientia_api_dio_provider.dart

Reports API DTOs:

    lib/features/reports/data/dtos/community_risk_report_create_request.dart
    lib/features/reports/data/dtos/community_risk_report_response.dart

Reports API client:

    lib/features/reports/data/datasources/community_risk_report_api_client.dart

AI Insight API DTOs:

    lib/features/ai_insight/data/dtos/ai_insight_create_request.dart
    lib/features/ai_insight/data/dtos/ai_insight_response.dart

AI Insight API client:

    lib/features/ai_insight/data/datasources/ai_insight_api_client.dart

## Prepared Integration Flow

    Flutter Community Risk Report form
    ↓
    POST /api/reports
    ↓
    receive report_id
    ↓
    POST /api/ai-insights
    ↓
    receive backend-generated AI insight
    ↓
    render AI insight result screen

## Current Limitation

The Flutter UI is not fully switched to backend mode yet.

The current public web demo remains usable with local mock behavior while backend integration is prepared safely.

## Verification

Commands:

    cd frontend/dscientia_app
    flutter analyze
    flutter test

Expected result:

    No analyzer issues
    All tests pass

## Next Milestone

    MVP-013 — Connect Flutter report flow to Laravel API behind a safe backend mode flag
