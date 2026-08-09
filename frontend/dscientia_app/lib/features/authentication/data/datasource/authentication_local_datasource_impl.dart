import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../../../../core/storage/auth_token_storage_keys.dart';
import '../models/auth_tokens_model.dart';
import 'authentication_local_datasource.dart';

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  const AuthenticationLocalDataSourceImpl(this._secureStorage);

  @override
  Future<void> saveTokens(AuthTokensModel tokens) async {
    await _secureStorage.write(
      key: AuthTokenStorageKeys.accessToken,
      value: tokens.accessToken,
    );

    await _secureStorage.write(
      key: AuthTokenStorageKeys.expiresAt,
      value: tokens.expiresAt.toIso8601String(),
    );
  }

  @override
  Future<AuthTokensModel?> getTokens() async {
    final values = await Future.wait([
      _secureStorage.read(key: AuthTokenStorageKeys.accessToken),
      _secureStorage.read(key: AuthTokenStorageKeys.expiresAt),
    ]);

    final accessToken = values[0];
    final expiresAtValue = values[1];

    if (accessToken == null || expiresAtValue == null) {
      return null;
    }

    final expiresAt = DateTime.tryParse(expiresAtValue);

    if (expiresAt == null) {
      await clearTokens();
      return null;
    }

    return AuthTokensModel(accessToken: accessToken, expiresAt: expiresAt);
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: AuthTokenStorageKeys.accessToken),
      _secureStorage.delete(key: AuthTokenStorageKeys.expiresAt),
    ]);
  }

  @override
  Future<bool> hasValidTokens() async {
    final tokens = await getTokens();

    if (tokens == null) {
      return false;
    }

    return tokens.expiresAt.toUtc().isAfter(DateTime.now().toUtc());
  }
}
