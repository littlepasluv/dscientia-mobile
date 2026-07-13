import 'auth_tokens.dart';
import 'user.dart';

class AuthSession {
  final User user;
  final AuthTokens tokens;
  final bool isAuthenticated;

  const AuthSession({
    required this.user,
    required this.tokens,
    required this.isAuthenticated,
  });
}
