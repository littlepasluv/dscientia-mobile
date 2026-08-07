import 'package:dscientia_app/app/app.dart';
import 'package:dscientia_app/features/authentication/domain/entities/auth_session.dart';
import 'package:dscientia_app/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:dscientia_app/features/authentication/presentation/providers/authentication_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthenticationRepository implements AuthenticationRepository {
  @override
  Future<AuthSession> login({required String email, required String password}) {
    throw UnimplementedError();
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
  Future<void> logout() async {}

  @override
  Future<AuthSession?> getCurrentSession() async {
    return null;
  }

  @override
  Future<void> forgotPassword({required String email}) async {}

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {}
}

void main() {
  testWidgets('App loads successfully', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          authenticationRepositoryProvider.overrideWith(
            (ref) => _FakeAuthenticationRepository(),
          ),
        ],
        child: const DscientiaApp(),
      ),
    );

    await tester.pumpAndSettle();

    expect(find.text('Community Resilience Dashboard'), findsOneWidget);
    expect(find.text('AI Insight for Community Resilience'), findsOneWidget);
    expect(find.text('Submit Community Risk Report'), findsOneWidget);
  });
}
