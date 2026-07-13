# MVP-013 — Flutter Backend Mode Integration

## Status

Completed locally.

## Purpose

This milestone connects the Flutter community risk report flow to the Laravel backend API behind a safe backend mode flag.

The public Flutter Web MVP remains safe because backend mode is disabled by default.

## Backend Mode Flag

Default behavior:

    DSCIENTIA_USE_BACKEND_API=false

When disabled, the app continues using the local mock AI insight flow.

Backend test behavior:

    DSCIENTIA_USE_BACKEND_API=true

When enabled, the Flutter app sends the submitted report to the Laravel API and generates an AI insight through the backend.

## Local Run Command

Laravel API:

    cd backend/dscientia_api
    php artisan serve --host=127.0.0.1 --port=8000

Flutter Web with backend mode:

    cd frontend/dscientia_app
    flutter run -d chrome \
      --dart-define=DSCIENTIA_USE_BACKEND_API=true \
      --dart-define=DSCIENTIA_API_BASE_URL=http://127.0.0.1:8000/api

## Implemented Flow

    Community Risk Report form
    ↓
    POST /api/reports
    ↓
    receive report_id
    ↓
    POST /api/ai-insights
    ↓
    receive backend-generated AI insight
    ↓
    render AI Insight Result screen

## Added Components

Backend mode config:

    lib/config/env/backend_mode_config.dart

Route data object:

    lib/features/ai_insight/presentation/navigation/ai_insight_result_route_data.dart

Updated router:

    lib/config/router/app_router.dart

Updated report screen:

    lib/features/reports/presentation/screens/community_risk_report_screen.dart

Updated result screen:

    lib/features/ai_insight/presentation/screens/ai_insight_result_screen.dart

## Verification Result

The local backend mode test successfully showed:

    Backend AI Insight
    Elevated Risk
    model_provider: mock
    model_name: dscientia-local-mock-v0.1

## Public Demo Safety

The deployed public app remains safe because backend mode is disabled unless explicitly enabled at build time.

Do not enable backend mode for production deployment until api.dscientia.dev is deployed and verified.

## Next Milestone

    DEPLOY-002 — Prepare api.dscientia.dev for Laravel API backend
