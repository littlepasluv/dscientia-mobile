import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/authentication_notifier.dart';
import '../providers/authentication_state.dart';

class AuthenticationBootstrap extends ConsumerStatefulWidget {
  final Widget child;

  const AuthenticationBootstrap({required this.child, super.key});

  @override
  ConsumerState<AuthenticationBootstrap> createState() =>
      _AuthenticationBootstrapState();
}

class _AuthenticationBootstrapState
    extends ConsumerState<AuthenticationBootstrap> {
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _hasStarted) {
        return;
      }

      _hasStarted = true;

      final AuthenticationState authState = ref.read(
        authenticationNotifierProvider,
      );

      if (!authState.isInitial) {
        return;
      }

      ref
          .read(authenticationNotifierProvider.notifier)
          .checkCurrentSession(silentFailure: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
