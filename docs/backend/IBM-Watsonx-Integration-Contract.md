# IBM/watsonx Integration Contract

## Status

The IBM/watsonx provider implementation is complete and covered by automated tests.

Controlled live IBM/watsonx verification remains pending because approved
IBM Cloud access, a watsonx.ai project, a Project ID, an IAM API key, and
supported model access are not currently available.

Production remains configured with the mock provider.

## Purpose

This document defines how DscienTia will connect its backend AI insight generation flow to IBM/watsonx in a safe and replaceable way.

The current MVP uses a provider abstraction so that the mock and IBM/watsonx
implementations can be selected without changing the API controller.

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

The Watsonx implementation is complete at the application integration boundary.
It includes IAM token acquisition, authenticated watsonx HTTP requests, prompt
construction, structured response mapping, retry handling, sanitized errors,
and optional mock fallback.

It must only be activated when valid IBM Cloud credentials, project configuration,
and supported model access are available.

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

## Current Integration Status

The IBM/watsonx provider integration boundary is implemented and covered by
automated tests.

The next required milestone is MVP-015E — Controlled IBM watsonx Verification,
which remains blocked until approved IBM Cloud access, a watsonx.ai project,
valid Project ID, IAM API key, and supported model access are available.

Production remains on the mock provider until controlled live verification is
successfully completed.
