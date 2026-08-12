# IBM Final Submission Visual Evidence

This directory contains visual evidence for the DscienTia MVP and final
production submission workflow.

## Final production evidence — 13 August 2026

### Production Dashboard

`production-dashboard-20260813.png`

Shows the current DscienTia Community Resilience Dashboard running in
production, including Demo Mode, MVP snapshot indicators, and the primary
community-risk workflow entry points.

### Backend AI Insight Overview

`production-backend-ai-insight-overview-20260813.png`

Shows the production end-to-end backend workflow after submitting an explicitly
synthetic community risk report through the Laravel API.

The screenshot includes:

- the `Backend AI Insight` indicator;
- the submitted synthetic source report;
- the generated medium-risk assessment; and
- the AI Risk Summary returned through the configured backend provider contract.

### Backend AI Insight Details

`production-backend-ai-insight-details-20260813.png`

Shows the technical and decision-support details returned by the production
backend workflow, including:

- risk level: Medium Risk;
- provider: `mock`;
- model: `dscientia-local-mock-v0.1`;
- confidence: 72%;
- suggested community action;
- recommended action steps; and
- the Ethical AI Note requiring human and local-context validation.

## Provider status

The current production AI provider remains `mock`.

These screenshots demonstrate the working Laravel backend AI-provider contract
and production decision-support workflow. They do not claim that a live IBM
watsonx request has been completed.

Controlled live watsonx verification remains dependent on IBM Cloud access and
configuration.

## Historical MVP evidence

The following files are preserved as earlier MVP evidence and are not the
preferred final-production screenshots:

- `main-dashboard.png`
- `ai-insight-result.png`

They document the earlier working interface and backend provider abstraction
before the final production evidence captured on 13 August 2026.
