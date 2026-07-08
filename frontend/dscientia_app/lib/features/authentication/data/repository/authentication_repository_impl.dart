import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasource/authentication_remote_datasource.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;

  const AuthenticationRepositoryImpl(this._remoteDataSource);

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final sessionModel = await _remoteDataSource.login(
      LoginRequest(email: email, password: password),
    );

    return sessionModel.toEntity();
  }

  @override
  Future<AuthSession> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    final sessionModel = await _remoteDataSource.register(
      RegisterRequest(fullName: fullName, email: email, password: password),
    );

    return sessionModel.toEntity();
  }

  @override
  Future<void> logout() async {
    await _remoteDataSource.logout();
  }

  @override
  Future<AuthSession> refreshSession() async {
    final sessionModel = await _remoteDataSource.refreshSession();

    return sessionModel.toEntity();
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    final sessionModel = await _remoteDataSource.getCurrentSession();

    return sessionModel?.toEntity();
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await _remoteDataSource.forgotPassword(email);
  }

  @override
  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    await _remoteDataSource.resetPassword(
      token: token,
      newPassword: newPassword,
    );
  }
}
