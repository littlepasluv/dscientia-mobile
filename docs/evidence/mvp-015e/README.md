# MVP-015E Evidence

## Purpose

This directory contains evidence for the controlled IBM watsonx.ai verification
of the DscienTia AI provider integration.

No API keys, access tokens, project IDs, credentials, or sensitive report data
may be stored in this directory.

## Current status

### Pre-Cloud readiness

Completed:

- controlled-verification preflight gate;
- synthetic non-personal community report fixture;
- local report creation through the Laravel API;
- structured AI insight verification through the mock provider;
- verification that no IBM network request was performed;
- verification that secret values were not displayed.

### Cloud-dependent verification

Pending:

- active IBM Cloud account or approved educational access;
- watsonx.ai project and runtime;
- valid Project ID;
- IBM Cloud IAM API key;
- confirmation that the configured Granite model is available in the selected region;
- one controlled live watsonx request;
- restoration of the local provider to mock after verification.

## Safety constraints

- Production must remain configured with `DSCIENTIA_AI_PROVIDER=mock`.
- Live verification must run only in a local environment.
- `WATSONX_FALLBACK_TO_MOCK=false` must be used during the controlled request.
- Only the synthetic verification report may be used.
- Exactly one live AI insight request should be performed.
- Credentials must never be committed or included in evidence.
- The local environment must be restored to the mock provider afterward.

## Evidence files

### `pre-cloud/preflight-blocked-2026-08-06.log`

Demonstrates that the verification gate refuses to authorize an IBM request
while the provider, fallback configuration, API key, or Project ID requirements
are not satisfied.

### `pre-cloud/mock-insight-verification-2026-08-06.log`

Demonstrates successful structured insight generation through the local mock
provider using a synthetic report, without contacting IBM.
