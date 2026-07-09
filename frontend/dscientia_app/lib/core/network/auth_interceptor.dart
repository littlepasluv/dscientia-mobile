import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../storage/auth_token_storage_keys.dart';

class AuthInterceptor extends Interceptor {
  final FlutterSecureStorage _secureStorage;

  AuthInterceptor(this._secureStorage);

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final accessToken = await _secureStorage.read(
      key: AuthTokenStorageKeys.accessToken,
    );

    final hasAuthorizationHeader = options.headers.containsKey('Authorization');

    if (accessToken != null &&
        accessToken.isNotEmpty &&
        !hasAuthorizationHeader) {
      options.headers['Authorization'] = 'Bearer $accessToken';
    }

    handler.next(options);
  }
}
