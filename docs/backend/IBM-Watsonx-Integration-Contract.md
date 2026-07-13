# IBM/watsonx Integration Contract

## Status

Contract prepared.

Real IBM/watsonx API calls are not enabled yet.

## Purpose

This document defines how DscienTia will connect its backend AI insight generation flow to IBM/watsonx in a safe and replaceable way.

The current MVP uses a local mock AI insight generator. The backend now uses a service contract so that the mock provider can later be replaced with a real IBM/watsonx provider without changing the API controller.

## Current Provider

```text
mock
```

## Future Provider

```text
watsonx
```

## Backend Contract

The backend uses:

```text
App\Contracts\AiInsightGenerator
```

The contract receives a community risk report and returns a structured AI insight result.

## Current Implementations

```text
App\Services\AiInsight\MockAiInsightGenerator
App\Services\AiInsight\WatsonxAiInsightGenerator
```

The Watsonx implementation is currently a placeholder.

It must not send external requests until credentials, model configuration, prompt governance, and response validation are finalized.

## Configuration

Configuration file:

```text
backend/dscientia_api/config/ai.php
```

Environment keys:

```text
DSCIENTIA_AI_PROVIDER=mock
WATSONX_API_KEY=
WATSONX_PROJECT_ID=
WATSONX_BASE_URL=https://us-south.ml.cloud.ibm.com
WATSONX_MODEL_ID=ibm/granite-3-8b-instruct
```

## Security Rule

IBM/watsonx credentials must only be stored in backend environment variables.

They must not be stored in:

- Flutter app code;
- Git repository;
- public web assets;
- frontend environment files.

## API Flow

```text
POST /api/reports
↓
CommunityRiskReport stored
↓
POST /api/ai-insights with report_id
↓
AiInsightGenerator contract called
↓
Structured AI insight stored
↓
AI insight response returned
```

## Accepted MVP Limitation

The current implementation still returns mock AI insight content.

This is intentional for MVP-010.

The purpose of this milestone is to prepare the integration boundary, not to activate IBM/watsonx production calls.

## Next Milestone

```text
MVP-011 — Backend API manual testing and Flutter integration preparation
```
