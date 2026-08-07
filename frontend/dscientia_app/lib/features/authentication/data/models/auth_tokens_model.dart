import '../../domain/entities/auth_tokens.dart';

class AuthTokensModel extends AuthTokens {
  const AuthTokensModel({required super.accessToken, required super.expiresAt});

  factory AuthTokensModel.fromJson(Map<String, dynamic> json) {
    return AuthTokensModel(
      accessToken: json['access_token'] as String,
      expiresAt: DateTime.parse(json['expires_at'] as String).toUtc(),
    );
  }

  AuthTokens toEntity() {
    return AuthTokens(accessToken: accessToken, expiresAt: expiresAt);
  }
}
