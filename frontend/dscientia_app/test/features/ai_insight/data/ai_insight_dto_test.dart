import 'package:dscientia_app/features/ai_insight/data/dtos/ai_insight_create_request.dart';
import 'package:dscientia_app/features/ai_insight/data/dtos/ai_insight_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('AiInsightCreateRequest converts to API JSON', () {
    const request = AiInsightCreateRequest(reportId: 2);

    expect(request.toJson(), {
      'report_id': 2,
      'insight_type': 'community_risk_summary',
    });
  });

  test('AiInsightResponse parses API JSON', () {
    final response = AiInsightResponse.fromJson({
      'id': 2,
      'report_id': 2,
      'insight_type': 'community_risk_summary',
      'risk_level': 'elevated',
      'narrative_summary':
          'The submitted report indicates an elevated community resilience concern.',
      'summary_points': [
        'Detected risk level: elevated',
        'Reported urgency: medium',
      ],
      'recommended_actions': [
        'Assign the report for immediate review.',
        'Contact the reporting organization.',
      ],
      'confidence_score': 0.72,
      'model_provider': 'mock',
      'model_name': 'dscientia-local-mock-v0.1',
      'status': 'completed',
      'created_at': '2026-07-13T20:21:25+00:00',
      'updated_at': '2026-07-13T20:21:25+00:00',
    });

    expect(response.id, 2);
    expect(response.reportId, 2);
    expect(response.riskLevel, 'elevated');
    expect(response.modelProvider, 'mock');
    expect(response.modelName, 'dscientia-local-mock-v0.1');
    expect(response.summaryPoints, hasLength(2));
    expect(response.recommendedActions, hasLength(2));
    expect(response.createdAt, isNotNull);
  });
}
