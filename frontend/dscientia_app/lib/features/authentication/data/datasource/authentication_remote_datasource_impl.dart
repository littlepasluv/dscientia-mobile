import 'package:dio/dio.dart';

import '../models/auth_session_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import 'authentication_remote_datasource.dart';

class AuthenticationRemoteDataSourceImpl
    implements AuthenticationRemoteDataSource {
  final Dio _dio;

  AuthenticationRemoteDataSourceImpl(this._dio);

  static const String _loginPath = '/auth/login';
  static const String _registerPath = '/auth/register';
  static const String _logoutPath = '/auth/logout';
  static const String _refreshSessionPath = '/auth/refresh';
  static const String _currentSessionPath = '/auth/session';
  static const String _forgotPasswordPath = '/auth/password/forgot';
  static const String _resetPasswordPath = '/auth/password/reset';

  @override
  Future<AuthSessionModel> login(LoginRequest request) async {
    final response = await _dio.post<dynamic>(
      _loginPath,
      data: request.toJson(),
    );

    return AuthSessionModel.fromJson(_extractResponseMap(response));
  }

  @override
  Future<AuthSessionModel> register(RegisterRequest request) async {
    final response = await _dio.post<dynamic>(
      _registerPath,
      data: request.toJson(),
    );

    return AuthSessionModel.fromJson(_extractResponseMap(response));
  }

  @override
  Future<void> logout() async {
    await _dio.post<dynamic>(_logoutPath);
  }

  @override
  Future<AuthSessionModel> refreshSession() async {
    final response = await _dio.post<dynamic>(_refreshSessionPath);

    return AuthSessionModel.fromJson(_extractResponseMap(response));
  }

  @override
  Future<AuthSessionModel?> getCurrentSession() async {
    try {
      final response = await _dio.get<dynamic>(_currentSessionPath);

      return AuthSessionModel.fromJson(_extractResponseMap(response));
    } on DioException catch (error) {
      if (error.response?.statusCode == 401) {
        return null;
      }

      rethrow;
    }
  }

  @override
  Future<void> forgotPassword(String email) async {
    await _dio.post<dynamic>(_forgotPasswordPath, data: {'email': email});
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await _dio.post<dynamic>(
      _resetPasswordPath,
      data: {'token': token, 'new_password': newPassword},
    );
  }

  Map<String, dynamic> _extractResponseMap(Response<dynamic> response) {
    final responseData = response.data;

    if (responseData is! Map) {
      throw const FormatException(
        'Authentication response must be a JSON object.',
      );
    }

    final responseMap = Map<String, dynamic>.from(responseData);
    final data = responseMap['data'];

    if (data is Map) {
      return Map<String, dynamic>.from(data);
    }

    return responseMap;
  }
}
