import '../../domain/entities/auth_session.dart';

enum AuthenticationStatus {
  initial,
  loading,
  authenticated,
  unauthenticated,
  error,
}

class AuthenticationState {
  final AuthenticationStatus status;
  final AuthSession? session;
  final String? errorMessage;

  const AuthenticationState._({
    required this.status,
    this.session,
    this.errorMessage,
  });

  const AuthenticationState.initial()
    : this._(status: AuthenticationStatus.initial);

  const AuthenticationState.loading()
    : this._(status: AuthenticationStatus.loading);

  const AuthenticationState.authenticated({required AuthSession session})
    : this._(status: AuthenticationStatus.authenticated, session: session);

  const AuthenticationState.unauthenticated()
    : this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState.error({required String message})
    : this._(status: AuthenticationStatus.error, errorMessage: message);

  bool get isInitial => status == AuthenticationStatus.initial;

  bool get isLoading => status == AuthenticationStatus.loading;

  bool get isAuthenticated =>
      status == AuthenticationStatus.authenticated && session != null;

  bool get isUnauthenticated => status == AuthenticationStatus.unauthenticated;

  bool get hasError => status == AuthenticationStatus.error;
}
