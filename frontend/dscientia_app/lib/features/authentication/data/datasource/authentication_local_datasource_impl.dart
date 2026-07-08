import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../models/auth_tokens_model.dart';
import 'authentication_local_datasource.dart';

class AuthenticationLocalDataSourceImpl
    implements AuthenticationLocalDataSource {
  final FlutterSecureStorage _secureStorage;

  const AuthenticationLocalDataSourceImpl(this._secureStorage);

  static const String _accessTokenKey = 'dscientia.auth.access_token';
  static const String _refreshTokenKey = 'dscientia.auth.refresh_token';
  static const String _expiresAtKey = 'dscientia.auth.expires_at';

  @override
  Future<void> saveTokens(AuthTokensModel tokens) async {
    await Future.wait([
      _secureStorage.write(key: _accessTokenKey, value: tokens.accessToken),
      _secureStorage.write(key: _refreshTokenKey, value: tokens.refreshToken),
      _secureStorage.write(
        key: _expiresAtKey,
        value: tokens.expiresAt.toIso8601String(),
      ),
    ]);
  }

  @override
  Future<AuthTokensModel?> getTokens() async {
    final values = await Future.wait([
      _secureStorage.read(key: _accessTokenKey),
      _secureStorage.read(key: _refreshTokenKey),
      _secureStorage.read(key: _expiresAtKey),
    ]);

    final accessToken = values[0];
    final refreshToken = values[1];
    final expiresAtValue = values[2];

    if (accessToken == null || refreshToken == null || expiresAtValue == null) {
      return null;
    }

    final expiresAt = DateTime.tryParse(expiresAtValue);

    if (expiresAt == null) {
      await clearTokens();
      return null;
    }

    return AuthTokensModel(
      accessToken: accessToken,
      refreshToken: refreshToken,
      expiresAt: expiresAt,
    );
  }

  @override
  Future<void> clearTokens() async {
    await Future.wait([
      _secureStorage.delete(key: _accessTokenKey),
      _secureStorage.delete(key: _refreshTokenKey),
      _secureStorage.delete(key: _expiresAtKey),
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
