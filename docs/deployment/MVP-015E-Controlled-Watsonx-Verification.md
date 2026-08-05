# MVP-015E — Controlled IBM watsonx.ai Verification

## Objective

Verify the DscienTia watsonx provider through one controlled request using
synthetic data, without enabling watsonx in production.

## Current Status

Pre-Cloud readiness is complete.

Live verification remains blocked until these resources are available:

- IBM Cloud access;
- watsonx.ai project and runtime;
- watsonx Project ID;
- IBM Cloud IAM API key;
- supported model in the selected region.

## Safety Constraints

- Production remains on `DSCIENTIA_AI_PROVIDER=mock`.
- Run live verification only in the local environment.
- Use only synthetic test data.
- Set `WATSONX_FALLBACK_TO_MOCK=false` during verification.
- Perform exactly one live AI request.
- Never commit credentials, tokens, Project IDs, or sensitive logs.
- Restore the local configuration to mock immediately afterward.

## Preconditions

1. Use branch `feature/watsonx-provider`.
2. Confirm the complete Laravel test suite passes.
3. Confirm the IBM Cloud and watsonx project are active.
4. Confirm the model is available in the project region.
5. Confirm production remains on the mock provider.
6. Use only the approved synthetic report.

## Local Controlled Configuration

Configure only `backend/dscientia_api/.env`:

```env
APP_ENV=local
DSCIENTIA_AI_PROVIDER=watsonx
WATSONX_API_KEY=<local-secret-only>
WATSONX_PROJECT_ID=<local-secret-only>
WATSONX_FALLBACK_TO_MOCK=false
