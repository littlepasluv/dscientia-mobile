import '../entities/auth_session.dart';

abstract class AuthenticationRepository {
  Future<AuthSession> login({required String email, required String password});

  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
  });

  Future<void> logout();

  Future<AuthSession?> getCurrentSession();

  Future<void> forgotPassword({required String email});

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  });
}
