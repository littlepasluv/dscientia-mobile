import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/authentication_repository.dart';
import '../datasource/authentication_local_datasource.dart';
import '../datasource/authentication_remote_datasource.dart';
import '../models/login_request.dart';
import '../models/register_request.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource _remoteDataSource;
  final AuthenticationLocalDataSource _localDataSource;

  const AuthenticationRepositoryImpl(
    this._remoteDataSource,
    this._localDataSource,
  );

  @override
  Future<AuthSession> login({
    required String email,
    required String password,
  }) async {
    final sessionModel = await _remoteDataSource.login(
      LoginRequest(email: email, password: password),
    );

    await _localDataSource.saveTokens(sessionModel.tokens);

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

    await _localDataSource.saveTokens(sessionModel.tokens);

    return sessionModel.toEntity();
  }

  @override
  Future<void> logout() async {
    try {
      await _remoteDataSource.logout();
    } finally {
      await _localDataSource.clearTokens();
    }
  }

  @override
  Future<AuthSession?> getCurrentSession() async {
    final hasValidTokens = await _localDataSource.hasValidTokens();

    if (!hasValidTokens) {
      return null;
    }

    final tokensModel = await _localDataSource.getTokens();

    if (tokensModel == null) {
      return null;
    }

    final userModel = await _remoteDataSource.getCurrentSession();

    if (userModel == null) {
      await _localDataSource.clearTokens();
      return null;
    }

    return AuthSession(
      user: userModel.toEntity(),
      tokens: tokensModel.toEntity(),
      isAuthenticated: true,
    );
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
