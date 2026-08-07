import 'package:dscientia_app/shared/widgets/app_brand_logo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('brand logo renders with accessible DscienTia label', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(appBar: AppBar(title: const AppBrandLogo())),
      ),
    );

    final logoFinder = find.byKey(const Key('app-brand-logo'));

    expect(logoFinder, findsOneWidget);
    expect(find.byType(Image), findsOneWidget);

    final semantics = tester.widget<Semantics>(logoFinder);
    expect(semantics.properties.label, 'DscienTia');
    expect(semantics.properties.image, isTrue);
  });
}
