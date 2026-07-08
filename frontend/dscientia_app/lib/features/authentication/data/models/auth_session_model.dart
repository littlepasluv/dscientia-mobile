import '../../domain/entities/auth_session.dart';
import 'auth_tokens_model.dart';
import 'user_model.dart';

class AuthSessionModel {
  final UserModel user;
  final AuthTokensModel tokens;

  const AuthSessionModel({
    required this.user,
    required this.tokens,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    final tokensJson =
        json['tokens'] as Map<String, dynamic>? ?? json;

    return AuthSessionModel(
      user: UserModel.fromJson(
        json['user'] as Map<String, dynamic>,
      ),
      tokens: AuthTokensModel.fromJson(tokensJson),
    );
  }

  AuthSession toEntity() {
    return AuthSession(
      user: user.toEntity(),
      tokens: tokens.toEntity(),
      isAuthenticated: true,
    );
  }
}