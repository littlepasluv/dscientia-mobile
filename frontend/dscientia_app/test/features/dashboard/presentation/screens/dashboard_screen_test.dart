import 'package:dscientia_app/features/authentication/domain/entities/auth_session.dart';
import 'package:dscientia_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dscientia_app/features/authentication/presentation/providers/authentication_notifier.dart';
import 'package:dscientia_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:dscientia_app/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthSession implements AuthSession {
  const _FakeAuthSession();

  @override
  dynamic noSuchMethod(Invocation invocation) {
    return super.noSuchMethod(invocation);
  }
}

class _RecordingAuthenticationRepository implements AuthenticationRepository {
  int logoutCallCount = 0;
  Object? logoutError;

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    return const _FakeAuthSession();
  }

  @override
  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    return const _FakeAuthSession();
  }

  @override
  Future<AuthSession?> getCurrentSession() async => null;

  @override
  Future<void> logout() async {
    logoutCallCount++;

    final error = logoutError;
    if (error != null) {
      throw error;
    }
  }

  @override
  Future<void> forgotPassword({required String email}) async {}

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {}
}

ProviderContainer _createContainer(
  _RecordingAuthenticationRepository repository,
) {
  return ProviderContainer(
    overrides: [
      authenticationRepositoryProvider.overrideWith((ref) => repository),
    ],
  );
}

Widget _buildDashboard(ProviderContainer container, {bool isDemoMode = false}) {
  final dashboard = isDemoMode
      ? const DashboardScreen.demo()
      : const DashboardScreen.authenticated();

  return UncontrolledProviderScope(
    container: container,
    child: MaterialApp(home: dashboard),
  );
}

void main() {
  testWidgets('Dashboard renders product-facing MVP sections', (tester) async {
    final repository = _RecordingAuthenticationRepository();
    final container = _createContainer(repository);
    addTearDown(container.dispose);

    await tester.pumpWidget(_buildDashboard(container, isDemoMode: true));

    expect(find.text('Community Resilience Dashboard'), findsOneWidget);
    expect(find.text('Today’s Snapshot'), findsOneWidget);
    expect(find.text('AI Insight for Community Resilience'), findsOneWidget);
    expect(find.text('Submit Community Risk Report'), findsOneWidget);
    expect(find.text('IBM Builder MVP Roadmap'), findsNothing);
  });

  testWidgets('Demo dashboard shows sign in and hides logout', (tester) async {
    final repository = _RecordingAuthenticationRepository();
    final container = _createContainer(repository);
    addTearDown(container.dispose);

    await tester.pumpWidget(_buildDashboard(container, isDemoMode: true));

    expect(find.text('Demo Mode'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
    expect(find.byTooltip('Log out'), findsNothing);
    expect(repository.logoutCallCount, 0);
  });

  testWidgets('Demo dashboard never shows logout for authenticated user', (
    tester,
  ) async {
    final repository = _RecordingAuthenticationRepository();
    final container = _createContainer(repository);
    addTearDown(container.dispose);

    await container
        .read(authenticationNotifierProvider.notifier)
        .login(email: 'test@example.com', password: 'test-password');

    await tester.pumpWidget(_buildDashboard(container, isDemoMode: true));
    await tester.pump();

    expect(find.text('Demo Mode'), findsOneWidget);
    expect(find.text('Exit demo'), findsOneWidget);
    expect(find.byTooltip('Log out'), findsNothing);
    expect(repository.logoutCallCount, 0);
  });

  testWidgets('Authenticated user can log out from dashboard', (tester) async {
    final repository = _RecordingAuthenticationRepository();
    final container = _createContainer(repository);
    addTearDown(container.dispose);

    await container
        .read(authenticationNotifierProvider.notifier)
        .login(email: 'test@example.com', password: 'test-password');

    await tester.pumpWidget(_buildDashboard(container));
    await tester.pump();

    expect(find.byTooltip('Log out'), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);

    await tester.tap(find.byTooltip('Log out'));
    await tester.pumpAndSettle();

    expect(repository.logoutCallCount, 1);
    expect(
      container.read(authenticationNotifierProvider).isUnauthenticated,
      isTrue,
    );
    expect(find.byTooltip('Log out'), findsNothing);
    expect(find.text('Log out'), findsNothing);
  });

  testWidgets('Failed logout keeps authenticated state and shows message', (
    tester,
  ) async {
    final repository = _RecordingAuthenticationRepository()
      ..logoutError = StateError('Expected logout failure.');
    final container = _createContainer(repository);
    addTearDown(container.dispose);

    await container
        .read(authenticationNotifierProvider.notifier)
        .login(email: 'test@example.com', password: 'test-password');

    await tester.pumpWidget(_buildDashboard(container));
    await tester.pump();

    await tester.tap(find.byTooltip('Log out'));
    await tester.pumpAndSettle();

    expect(repository.logoutCallCount, 1);
    expect(
      container.read(authenticationNotifierProvider).isAuthenticated,
      isTrue,
    );
    expect(find.byTooltip('Log out'), findsOneWidget);
    expect(find.text('Log out'), findsOneWidget);
    expect(
      find.text('Unable to log out safely. Please try again.'),
      findsOneWidget,
    );
  });
}
