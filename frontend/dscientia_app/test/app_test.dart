import 'package:dscientia_app/app/app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('App loads successfully', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: DscientiaApp()));

    await tester.pumpAndSettle();

    expect(find.text('Welcome back to DscienTia'), findsOneWidget);
    expect(find.text('Sign in'), findsWidgets);
  });
}
