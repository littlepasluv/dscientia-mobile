import 'package:dscientia_app/features/reports/data/dtos/community_risk_report_create_request.dart';
import 'package:dscientia_app/features/reports/data/dtos/community_risk_report_response.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CommunityRiskReportCreateRequest converts to API JSON', () {
    const request = CommunityRiskReportCreateRequest(
      organizationName: 'Razy Zone International',
      reporterName: 'Prio Nugroho',
      category: 'community_needs',
      location: 'Sudan',
      urgency: 'medium',
      description:
          'Community members reported urgent local needs that require action.',
      affectedPeopleCount: 120,
      sourceUrl: 'https://app.dscientia.dev',
    );

    expect(request.toJson(), {
      'organization_name': 'Razy Zone International',
      'reporter_name': 'Prio Nugroho',
      'category': 'community_needs',
      'location': 'Sudan',
      'urgency': 'medium',
      'description':
          'Community members reported urgent local needs that require action.',
      'affected_people_count': 120,
      'source_url': 'https://app.dscientia.dev',
    });
  });

  test('CommunityRiskReportResponse parses API JSON', () {
    final response = CommunityRiskReportResponse.fromJson({
      'id': 2,
      'organization_name': 'Razy Zone International',
      'reporter_name': 'Prio Nugroho',
      'category': 'community_needs',
      'location': 'Sudan',
      'urgency': 'medium',
      'description':
          'Community members reported urgent local needs that require action.',
      'affected_people_count': 120,
      'status': 'open',
      'source_url': 'https://app.dscientia.dev',
      'created_at': '2026-07-13T20:21:25+00:00',
      'updated_at': '2026-07-13T20:21:25+00:00',
    });

    expect(response.id, 2);
    expect(response.organizationName, 'Razy Zone International');
    expect(response.urgency, 'medium');
    expect(response.status, 'open');
    expect(response.affectedPeopleCount, 120);
    expect(response.createdAt, isNotNull);
  });
}
