import 'package:dscientia_app/features/authentication/data/datasource/authentication_local_datasource.dart';
import 'package:dscientia_app/features/authentication/data/datasource/authentication_remote_datasource.dart';
import 'package:dscientia_app/features/authentication/data/models/auth_tokens_model.dart';
import 'package:dscientia_app/features/authentication/data/models/user_model.dart';
import 'package:dscientia_app/features/authentication/data/repository/authentication_repository_impl.dart';
import 'package:flutter_test/flutter_test.dart';

class _FakeAuthenticationRemoteDataSource extends Fake
    implements AuthenticationRemoteDataSource {
  final UserModel? currentUser;

  int getCurrentSessionCallCount = 0;

  _FakeAuthenticationRemoteDataSource({required this.currentUser});

  @override
  Future<UserModel?> getCurrentSession() async {
    getCurrentSessionCallCount++;
    return currentUser;
  }
}

class _FakeAuthenticationLocalDataSource extends Fake
    implements AuthenticationLocalDataSource {
  final bool hasValidTokensResult;
  final AuthTokensModel? tokens;

  int hasValidTokensCallCount = 0;
  int getTokensCallCount = 0;
  int clearTokensCallCount = 0;

  _FakeAuthenticationLocalDataSource({
    required this.hasValidTokensResult,
    required this.tokens,
  });

  @override
  Future<bool> hasValidTokens() async {
    hasValidTokensCallCount++;
    return hasValidTokensResult;
  }

  @override
  Future<AuthTokensModel?> getTokens() async {
    getTokensCallCount++;
    return tokens;
  }

  @override
  Future<void> clearTokens() async {
    clearTokensCallCount++;
  }
}

void main() {
  group('AuthenticationRepositoryImpl', () {
    test('combines the remote user with locally stored valid tokens', () async {
      final expiresAt = DateTime.utc(2100, 1, 1);
      final createdAt = DateTime.utc(2026, 8, 7, 12);

      final remoteDataSource = _FakeAuthenticationRemoteDataSource(
        currentUser: UserModel(
          id: '1',
          email: 'session@example.com',
          fullName: 'Session User',
          role: 'community_leader',
          isEmailVerified: true,
          createdAt: createdAt,
        ),
      );

      final localDataSource = _FakeAuthenticationLocalDataSource(
        hasValidTokensResult: true,
        tokens: AuthTokensModel(
          accessToken: 'local-access-token',
          expiresAt: expiresAt,
        ),
      );

      final repository = AuthenticationRepositoryImpl(
        remoteDataSource,
        localDataSource,
      );

      final result = await repository.getCurrentSession();

      expect(result, isNotNull);

      final session = result!;

      expect(session.isAuthenticated, isTrue);
      expect(session.user.id, '1');
      expect(session.user.email, 'session@example.com');
      expect(session.user.fullName, 'Session User');
      expect(session.user.role, 'community_leader');
      expect(session.user.isEmailVerified, isTrue);
      expect(session.user.createdAt, createdAt);
      expect(session.tokens.accessToken, 'local-access-token');
      expect(session.tokens.expiresAt, expiresAt);

      expect(localDataSource.hasValidTokensCallCount, 1);
      expect(localDataSource.getTokensCallCount, 1);
      expect(remoteDataSource.getCurrentSessionCallCount, 1);
      expect(localDataSource.clearTokensCallCount, 0);
    });

    test(
      'returns null without calling remote when local tokens are invalid',
      () async {
        final remoteDataSource = _FakeAuthenticationRemoteDataSource(
          currentUser: null,
        );

        final localDataSource = _FakeAuthenticationLocalDataSource(
          hasValidTokensResult: false,
          tokens: null,
        );

        final repository = AuthenticationRepositoryImpl(
          remoteDataSource,
          localDataSource,
        );

        final result = await repository.getCurrentSession();

        expect(result, isNull);
        expect(localDataSource.hasValidTokensCallCount, 1);
        expect(localDataSource.getTokensCallCount, 0);
        expect(remoteDataSource.getCurrentSessionCallCount, 0);
        expect(localDataSource.clearTokensCallCount, 0);
      },
    );

    test(
      'clears local tokens when the remote session is unavailable',
      () async {
        final remoteDataSource = _FakeAuthenticationRemoteDataSource(
          currentUser: null,
        );

        final localDataSource = _FakeAuthenticationLocalDataSource(
          hasValidTokensResult: true,
          tokens: AuthTokensModel(
            accessToken: 'expired-session-token',
            expiresAt: DateTime.utc(2100, 1, 1),
          ),
        );

        final repository = AuthenticationRepositoryImpl(
          remoteDataSource,
          localDataSource,
        );

        final result = await repository.getCurrentSession();

        expect(result, isNull);
        expect(localDataSource.hasValidTokensCallCount, 1);
        expect(localDataSource.getTokensCallCount, 1);
        expect(remoteDataSource.getCurrentSessionCallCount, 1);
        expect(localDataSource.clearTokensCallCount, 1);
      },
    );
  });
}
