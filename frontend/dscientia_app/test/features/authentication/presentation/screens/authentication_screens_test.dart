import 'package:dscientia_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:dscientia_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Widget buildScreen(Widget screen) {
    return ProviderScope(child: MaterialApp(home: screen));
  }

  testWidgets('Login screen renders core authentication controls', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen(const LoginScreen()));

    expect(find.text('Welcome back to DscienTia'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
  });

  testWidgets('Register screen renders core authentication controls', (
    tester,
  ) async {
    await tester.pumpWidget(buildScreen(const RegisterScreen()));

    expect(find.text('Join DscienTia'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Full name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Create account'), findsOneWidget);
    expect(find.text('Already have an account? Sign in'), findsOneWidget);
  });
}
