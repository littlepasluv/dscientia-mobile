import 'package:dscientia_app/core/storage/auth_token_storage_keys.dart';
import 'package:dscientia_app/features/authentication/data/datasource/authentication_local_datasource_impl.dart';
import 'package:dscientia_app/features/authentication/data/models/auth_tokens_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  const secureStorage = FlutterSecureStorage();
  late AuthenticationLocalDataSourceImpl dataSource;

  setUp(() {
    FlutterSecureStorage.setMockInitialValues(<String, String>{});
    dataSource = const AuthenticationLocalDataSourceImpl(secureStorage);
  });

  group('AuthenticationLocalDataSourceImpl', () {
    final expiresAt = DateTime.utc(2026, 8, 8, 12);

    test('saves only access token and expiration time', () async {
      final tokens = AuthTokensModel(
        accessToken: 'access-token',
        expiresAt: expiresAt,
      );

      await dataSource.saveTokens(tokens);

      expect(await secureStorage.readAll(), <String, String>{
        AuthTokenStorageKeys.accessToken: 'access-token',
        AuthTokenStorageKeys.expiresAt: expiresAt.toIso8601String(),
      });
    });

    test('returns tokens without requiring a refresh token', () async {
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        AuthTokenStorageKeys.accessToken: 'access-token',
        AuthTokenStorageKeys.expiresAt: expiresAt.toIso8601String(),
      });

      final tokens = await dataSource.getTokens();

      expect(tokens, isNotNull);
      expect(tokens!.accessToken, 'access-token');
      expect(tokens.expiresAt, expiresAt);
    });

    test('returns null when the expiration time is invalid', () async {
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        AuthTokenStorageKeys.accessToken: 'access-token',
        AuthTokenStorageKeys.expiresAt: 'invalid-date',
      });

      final tokens = await dataSource.getTokens();

      expect(tokens, isNull);
      expect(
        await secureStorage.read(key: AuthTokenStorageKeys.accessToken),
        isNull,
      );
      expect(
        await secureStorage.read(key: AuthTokenStorageKeys.expiresAt),
        isNull,
      );
    });

    test('clears stored authentication tokens', () async {
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        AuthTokenStorageKeys.accessToken: 'access-token',
        AuthTokenStorageKeys.expiresAt: expiresAt.toIso8601String(),
        'unrelated-key': 'preserved-value',
      });

      await dataSource.clearTokens();

      expect(await secureStorage.readAll(), <String, String>{
        'unrelated-key': 'preserved-value',
      });
    });

    test('reports that an expired token is invalid', () async {
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        AuthTokenStorageKeys.accessToken: 'access-token',
        AuthTokenStorageKeys.expiresAt: DateTime.utc(2000).toIso8601String(),
      });

      expect(await dataSource.hasValidTokens(), isFalse);
    });

    test('reports that an unexpired token is valid', () async {
      FlutterSecureStorage.setMockInitialValues(<String, String>{
        AuthTokenStorageKeys.accessToken: 'access-token',
        AuthTokenStorageKeys.expiresAt: DateTime.utc(2100).toIso8601String(),
      });

      expect(await dataSource.hasValidTokens(), isTrue);
    });
  });
}
