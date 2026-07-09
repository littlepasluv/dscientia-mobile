# AI Insight MVP Baseline v1.0

## Review Status

Status: Accepted as MVP baseline

Date: 2026-07-09

Scope:

```text
AI Insight Flutter MVP
Community Risk Report Draft
Mock AI Insight Generator
AI Insight Result Screen
IBM/watsonx integration direction
```

## Baseline Summary

The AI Insight MVP baseline establishes the first visible AI-powered product flow in DscienTia.

The feature currently supports:

- collecting a community risk report draft;
- generating a mock AI insight locally;
- displaying structured insight output;
- showing priority assessment;
- showing recommended action steps;
- showing ethical AI guidance.

## Accepted Current Flow

```text
Dashboard
↓
Community Risk Report Form
↓
CommunityRiskReportDraft
↓
MockAiInsightGenerator
↓
AiInsight
↓
AI Insight Result Screen
```

## Accepted Files

Flutter implementation:

```text
frontend/dscientia_app/lib/features/reports/domain/entities/community_risk_report_draft.dart
frontend/dscientia_app/lib/features/ai_insight/domain/entities/ai_insight.dart
frontend/dscientia_app/lib/features/ai_insight/domain/services/mock_ai_insight_generator.dart
frontend/dscientia_app/lib/features/ai_insight/presentation/screens/ai_insight_result_screen.dart
```

Routing and entry points:

```text
frontend/dscientia_app/lib/config/router/app_router.dart
frontend/dscientia_app/lib/features/dashboard/presentation/screens/dashboard_screen.dart
frontend/dscientia_app/lib/features/reports/presentation/screens/community_risk_report_screen.dart
```

Tests:

```text
frontend/dscientia_app/test/features/ai_insight/presentation/screens/ai_insight_result_screen_test.dart
frontend/dscientia_app/test/features/reports/presentation/screens/community_risk_report_screen_test.dart
```

## Accepted Output Structure

The baseline AI insight output contains:

```text
summary
priorityLabel
priorityRationale
suggestedAction
actionSteps
ethicalNote
```

This structure is accepted as the initial contract for the future backend AI response.

## Architecture Assessment

### Strengths

- UI is separated from mock insight generation.
- AI output is represented as a domain object.
- The report draft is explicit and portable.
- The result screen is ready for future backend data.
- Ethical AI guidance is part of the product output.
- The flow is demo-ready without backend dependency.

### Current Limitations

- No backend persistence.
- No real AI API call.
- No IBM/watsonx API integration yet.
- No saved report history.
- No insight audit trail.
- No confidence score.
- No role-based access.
- No localization.

These limitations are acceptable for MVP baseline v1.0.

## IBM Builder Readiness Assessment

Current readiness:

```text
Product narrative        : improving
Visible AI MVP flow      : yes
IBM/watsonx integration  : planned
Demo capability          : partial
Backend readiness        : not yet
Formal submission ready  : no
```

This baseline supports the roadmap toward Gate 2 — Soft Submit Ready.

## Gate Alignment

### Gate 1 — Not Ready

Status: Passed as current checkpoint

Reason:

Authentication foundation and visible AI mock flow are progressing, but backend and IBM/watsonx integration are not ready yet.

### Gate 2 — Soft Submit Ready

Target:

```text
2026-08-07
```

Minimum required additions:

- minimal backend AI Insight endpoint;
- report API;
- structured AI response contract;
- IBM/watsonx integration direction documented;
- basic demo scenario prepared.

### Gate 3 — Formal Submit Ready

Target:

```text
2026-08-20
```

Minimum required additions:

- working end-to-end MVP;
- technical architecture diagram;
- pitch deck;
- demo video;
- clean README;
- final application package.

## Decision

AI Insight MVP Baseline v1.0 is accepted.

The next implementation work should move toward backend architecture and API readiness rather than expanding UI complexity too early.

## Next Recommended Milestone

```text
MVP-006 — Backend Architecture for Reports and AI Insights
```