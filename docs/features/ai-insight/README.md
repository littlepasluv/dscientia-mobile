# AI Insight Feature

The AI Insight feature is the core MVP capability of DscienTia.

It transforms a community risk report into a structured resilience insight that can help local communities understand risk, prioritize response, and prepare practical actions.

This feature is designed as the first IBM Builder-ready MVP slice for DscienTia.

## Purpose

The purpose of AI Insight is to support community resilience decision-making through:

- risk summarization;
- priority assessment;
- suggested community action;
- practical action steps;
- ethical AI guidance.

## Current MVP Status

The current implementation uses a local mock AI insight generator.

This allows the Flutter app to demonstrate the complete product flow before the Laravel backend and IBM/watsonx integration are connected.

Current flow:

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

## Current Implementation

Flutter files:

```text
frontend/dscientia_app/lib/features/reports/domain/entities/community_risk_report_draft.dart
frontend/dscientia_app/lib/features/ai_insight/domain/entities/ai_insight.dart
frontend/dscientia_app/lib/features/ai_insight/domain/services/mock_ai_insight_generator.dart
frontend/dscientia_app/lib/features/ai_insight/presentation/screens/ai_insight_result_screen.dart
```

Test file:

```text
frontend/dscientia_app/test/features/ai_insight/presentation/screens/ai_insight_result_screen_test.dart
```

## MVP Output

The current AI Insight result provides:

- source report context;
- AI risk summary;
- priority assessment;
- suggested community action;
- recommended action steps;
- ethical AI note.

## IBM/watsonx Direction

The mock generator is intentionally isolated from the UI so it can later be replaced by a backend-powered AI service.

Future direction:

```text
MockAiInsightGenerator
↓
Laravel AI Insight API
↓
IBM watsonx.ai service layer
↓
Structured JSON insight response
↓
Flutter AI Insight Result Screen
```

## MVP Role

AI Insight is the main product differentiator in the DscienTia MVP.

Without this feature, DscienTia is mainly a community reporting app. With AI Insight, DscienTia becomes a decision-support tool for community resilience.

## Related Documents

- [Architecture](Architecture.md)
- [AI Insight MVP Baseline v1.0](../../reviews/ai-insight/AI-Insight-MVP-Baseline-v1.0.md)