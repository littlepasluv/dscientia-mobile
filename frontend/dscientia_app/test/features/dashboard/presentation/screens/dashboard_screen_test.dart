import 'package:dscientia_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('Dashboard skeleton renders core MVP sections', (tester) async {
    await tester.pumpWidget(const MaterialApp(home: DashboardScreen()));

    expect(find.text('Community Resilience Dashboard'), findsOneWidget);
    expect(find.text('Today’s Snapshot'), findsOneWidget);
    expect(find.text('AI Insight for Community Resilience'), findsOneWidget);
    expect(find.text('Submit Community Risk Report'), findsOneWidget);
    expect(find.text('IBM Builder MVP Roadmap'), findsOneWidget);
  });
}
