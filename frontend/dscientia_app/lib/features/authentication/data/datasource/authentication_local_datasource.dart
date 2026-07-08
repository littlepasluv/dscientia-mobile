import '../models/auth_tokens_model.dart';

abstract class AuthenticationLocalDataSource {
  Future<void> saveTokens(AuthTokensModel tokens);

  Future<AuthTokensModel?> getTokens();

  Future<void> clearTokens();

  Future<bool> hasValidTokens();
}
