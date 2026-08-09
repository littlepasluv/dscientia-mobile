import 'package:dscientia_app/features/authentication/domain/entities/auth_session.dart';
import 'package:dscientia_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dscientia_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:dscientia_app/features/authentication/presentation/screens/login_screen.dart';
import 'package:dscientia_app/features/authentication/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _RecordingAuthenticationRepository implements AuthenticationRepository {
  int loginCallCount = 0;
  int registerCallCount = 0;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    loginCallCount++;
    throw StateError('Login must not be called for invalid input.');
  }

  @override
  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    registerCallCount++;
    throw StateError('Register must not be called for invalid input.');
  }

  @override
  Future<AuthSession?> getCurrentSession() async => null;

  @override
  Future<void> logout() async {}

  @override
  Future<void> forgotPassword({required String email}) async {}

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {}
}

void main() {
  Widget buildScreen(
    Widget screen,
    _RecordingAuthenticationRepository repository,
  ) {
    return ProviderScope(
      overrides: [
        authenticationRepositoryProvider.overrideWith((ref) => repository),
      ],
      child: MaterialApp(home: screen),
    );
  }

  testWidgets('Login screen renders core authentication controls', (
    tester,
  ) async {
    final repository = _RecordingAuthenticationRepository();

    await tester.pumpWidget(buildScreen(const LoginScreen(), repository));

    expect(find.text('Welcome back to DscienTia'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
    expect(find.text('Create an account'), findsOneWidget);
  });

  testWidgets(
    'Login empty submit shows validation without calling repository',
    (tester) async {
      final repository = _RecordingAuthenticationRepository();

      await tester.pumpWidget(buildScreen(const LoginScreen(), repository));

      await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
      await tester.pump();

      expect(find.text('Email is required.'), findsOneWidget);
      expect(find.text('Password is required.'), findsOneWidget);
      expect(repository.loginCallCount, 0);
    },
  );

  testWidgets('Register screen renders core authentication controls', (
    tester,
  ) async {
    final repository = _RecordingAuthenticationRepository();

    await tester.pumpWidget(buildScreen(const RegisterScreen(), repository));

    expect(find.text('Join DscienTia'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Full name'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.widgetWithText(FilledButton, 'Create account'), findsOneWidget);
    expect(find.text('Already have an account? Sign in'), findsOneWidget);
  });

  testWidgets(
    'Register empty submit shows validation without calling repository',
    (tester) async {
      final repository = _RecordingAuthenticationRepository();

      await tester.pumpWidget(buildScreen(const RegisterScreen(), repository));

      await tester.tap(find.widgetWithText(FilledButton, 'Create account'));
      await tester.pump();

      expect(find.text('Full name is required.'), findsOneWidget);
      expect(find.text('Email is required.'), findsOneWidget);
      expect(find.text('Password is required.'), findsOneWidget);
      expect(repository.registerCallCount, 0);
    },
  );
}
