import 'package:dscientia_app/features/ai_insight/presentation/screens/ai_insight_result_screen.dart';
import 'package:dscientia_app/features/reports/domain/entities/community_risk_report_draft.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('AI insight result screen renders generated insight sections', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: AiInsightResultScreen(report: CommunityRiskReportDraft.demo()),
      ),
    );

    expect(
      find.text('AI-Powered Community Resilience Insight'),
      findsOneWidget,
    );
    expect(find.text('Source Report'), findsOneWidget);
    expect(find.text('AI Risk Summary'), findsOneWidget);
    expect(find.text('Priority Assessment'), findsOneWidget);
    expect(find.text('Suggested Community Action'), findsOneWidget);
    expect(find.text('Recommended Action Steps'), findsOneWidget);
    expect(find.text('Ethical AI Note'), findsOneWidget);
  });
}
