import 'package:dscientia_app/features/reports/presentation/screens/community_risk_report_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Community risk report form renders core fields', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: CommunityRiskReportScreen()),
    );

    expect(find.text('Community Risk Report'), findsOneWidget);
    expect(find.text('Submit Community Risk Report'), findsOneWidget);
    expect(find.text('Report title'), findsOneWidget);
    expect(find.text('Category'), findsOneWidget);
    expect(find.text('Location'), findsOneWidget);
    expect(find.text('Description'), findsOneWidget);
    expect(find.text('Urgency level'), findsOneWidget);
    expect(find.text('Prepare AI Insight'), findsOneWidget);
  });
}
