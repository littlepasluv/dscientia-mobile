import '../models/auth_session_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthSessionModel> login(
      LoginRequest request,
      );

  Future<AuthSessionModel> register(
      RegisterRequest request,
      );

  Future<void> logout();

  Future<AuthSessionModel> refreshSession();

  Future<AuthSessionModel?> getCurrentSession();

  Future<void> forgotPassword(
      String email,
      );

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}