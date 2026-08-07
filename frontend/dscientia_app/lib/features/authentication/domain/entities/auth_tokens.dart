class AuthTokens {
  const AuthTokens({required this.accessToken, required this.expiresAt});

  final String accessToken;
  final DateTime expiresAt;

  bool get isExpired => !expiresAt.isAfter(DateTime.now());

  bool get isValid => accessToken.isNotEmpty && !isExpired;
}
