import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/authentication_repository.dart';
import 'authentication_providers.dart';
import 'authentication_state.dart';

final authenticationNotifierProvider =
    NotifierProvider<AuthenticationNotifier, AuthenticationState>(
      AuthenticationNotifier.new,
    );

class AuthenticationNotifier extends Notifier<AuthenticationState> {
  late final AuthenticationRepository _repository;

  @override
  AuthenticationState build() {
    _repository = ref.watch(authenticationRepositoryProvider);

    return const AuthenticationState.initial();
  }

  Future<void> checkCurrentSession() async {
    state = const AuthenticationState.loading();

    try {
      final session = await _repository.getCurrentSession();

      if (session == null) {
        state = const AuthenticationState.unauthenticated();
        return;
      }

      state = AuthenticationState.authenticated(session: session);
    } catch (error) {
      state = AuthenticationState.error(message: _messageFromError(error));
    }
  }

  Future<void> login({required String email, required String password}) async {
    state = const AuthenticationState.loading();

    try {
      final session = await _repository.login(email: email, password: password);

      state = AuthenticationState.authenticated(session: session);
    } catch (error) {
      state = AuthenticationState.error(message: _messageFromError(error));
    }
  }

  Future<void> register({
    required String fullName,
    required String email,
    required String password,
  }) async {
    state = const AuthenticationState.loading();

    try {
      final session = await _repository.register(
        fullName: fullName,
        email: email,
        password: password,
      );

      state = AuthenticationState.authenticated(session: session);
    } catch (error) {
      state = AuthenticationState.error(message: _messageFromError(error));
    }
  }

  Future<void> logout() async {
    state = const AuthenticationState.loading();

    try {
      await _repository.logout();

      state = const AuthenticationState.unauthenticated();
    } catch (error) {
      state = AuthenticationState.error(message: _messageFromError(error));
    }
  }

  Future<void> forgotPassword({required String email}) async {
    state = const AuthenticationState.loading();

    try {
      await _repository.forgotPassword(email: email);

      state = const AuthenticationState.unauthenticated();
    } catch (error) {
      state = AuthenticationState.error(message: _messageFromError(error));
    }
  }

  Future<void> resetPassword({
    required String token,
    required String newPassword,
  }) async {
    state = const AuthenticationState.loading();

    try {
      await _repository.resetPassword(token: token, newPassword: newPassword);

      state = const AuthenticationState.unauthenticated();
    } catch (error) {
      state = AuthenticationState.error(message: _messageFromError(error));
    }
  }

  String _messageFromError(Object error) {
    return error.toString();
  }
}
