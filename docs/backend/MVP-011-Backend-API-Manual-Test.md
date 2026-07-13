# MVP-011 — Backend API Manual Testing

## Status

Completed locally.

## Purpose

This document records the manual API testing flow for the DscienTia Laravel backend.

The goal is to verify that the backend can:

- respond to health checks;
- create a community risk report;
- generate a mock AI insight from a report;
- retrieve the created report;
- retrieve the generated AI insight.

## Local API Base URL

    http://127.0.0.1:8000/api

## Tested Endpoints

    GET  /api/health
    POST /api/reports
    GET  /api/reports
    GET  /api/reports/{report}
    POST /api/ai-insights
    GET  /api/ai-insights/{aiInsight}

## Manual Test Flow

    GET /api/health
    ↓
    POST /api/reports
    ↓
    Extract report_id
    ↓
    POST /api/ai-insights
    ↓
    Extract ai_insight_id
    ↓
    GET /api/reports/{report}
    ↓
    GET /api/ai-insights/{aiInsight}

## Sample Report Payload

    {
      "organization_name": "Razy Zone International",
      "reporter_name": "Prio Nugroho",
      "category": "community_needs",
      "location": "Sudan",
      "urgency": "medium",
      "description": "Community members reported urgent local needs that require documentation, coordination, and follow-up action.",
      "affected_people_count": 120,
      "source_url": "https://app.dscientia.dev"
    }

## Expected AI Insight Result

The mock AI insight generator should return:

    risk_level: elevated
    model_provider: mock
    model_name: dscientia-local-mock-v0.1
    status: completed

## Current Provider

    DSCIENTIA_AI_PROVIDER=mock

## Result

The backend API flow is ready for Flutter integration preparation.

## Next Milestone

    MVP-012 — Flutter API client preparation
