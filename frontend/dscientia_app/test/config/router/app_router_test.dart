import 'dart:async';

import 'package:dscientia_app/config/router/app_router.dart';
import 'package:dscientia_app/features/authentication/domain/entities/auth_session.dart';
import 'package:dscientia_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dscientia_app/features/authentication/presentation/providers/authentication_notifier.dart';
import 'package:dscientia_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _PendingAuthenticationRepository implements AuthenticationRepository {
  final loginCompleter = Completer<AuthSession>();

  @override
  Future<AuthSession> login({required String email, required String password}) {
    return loginCompleter.future;
  }

  @override
  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
  }) {
    throw UnimplementedError();
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
  testWidgets(
    'Authentication loading keeps router instance and active login route',
    (tester) async {
      final repository = _PendingAuthenticationRepository();
      late WidgetRef appRef;

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            authenticationRepositoryProvider.overrideWith((ref) => repository),
          ],
          child: Consumer(
            builder: (context, ref, child) {
              appRef = ref;

              return MaterialApp.router(
                routerConfig: ref.watch(appRouterProvider),
              );
            },
          ),
        ),
      );

      await tester.pumpAndSettle();

      final routerBeforeLoading = appRef.read(appRouterProvider);

      routerBeforeLoading.go('/login');
      await tester.pumpAndSettle();

      expect(
        routerBeforeLoading.routeInformationProvider.value.uri.path,
        '/login',
      );
      expect(find.text('Welcome back to DscienTia'), findsOneWidget);

      final loginFuture = appRef
          .read(authenticationNotifierProvider.notifier)
          .login(email: 'test@example.com', password: 'test-password');

      await tester.pump();

      final routerDuringLoading = appRef.read(appRouterProvider);

      expect(identical(routerDuringLoading, routerBeforeLoading), isTrue);
      expect(
        routerDuringLoading.routeInformationProvider.value.uri.path,
        '/login',
      );
      expect(find.text('Welcome back to DscienTia'), findsOneWidget);

      repository.loginCompleter.completeError(
        StateError('Expected test login failure.'),
      );

      await loginFuture;
      await tester.pump();
    },
  );
}
