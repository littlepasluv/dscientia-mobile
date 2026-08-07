import '../models/auth_session_model.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';
import '../models/user_model.dart';

abstract class AuthenticationRemoteDataSource {
  Future<AuthSessionModel> login(LoginRequest request);

  Future<AuthSessionModel> register(RegisterRequest request);

  Future<void> logout();

  Future<UserModel?> getCurrentSession();

  Future<void> forgotPassword(String email);

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}
