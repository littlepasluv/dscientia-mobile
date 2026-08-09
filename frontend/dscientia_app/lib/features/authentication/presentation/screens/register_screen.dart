import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/widgets/app_auth_shell.dart';
import '../providers/authentication_notifier.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String? _fullNameError;
  String? _emailError;
  String? _passwordError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final fullName = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    setState(() {
      _fullNameError = fullName.isEmpty ? 'Full name is required.' : null;
      _emailError = email.isEmpty ? 'Email is required.' : null;
      _passwordError = password.isEmpty ? 'Password is required.' : null;
    });

    if (_fullNameError != null ||
        _emailError != null ||
        _passwordError != null) {
      return;
    }

    await ref
        .read(authenticationNotifierProvider.notifier)
        .register(fullName: fullName, email: email, password: password);
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authenticationNotifierProvider);
    final isLoading = authState.isLoading;

    return AppAuthShell(
      appBarTitle: 'Create account',
      title: 'Join DscienTia',
      description:
          'Create an account to support data-driven community resilience.',
      icon: Icons.person_add_alt_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextField(
            controller: _fullNameController,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
            decoration: InputDecoration(
              labelText: 'Full name',
              prefixIcon: const Icon(Icons.person_outline),
              errorText: _fullNameError,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            decoration: InputDecoration(
              labelText: 'Email',
              hintText: 'name@example.com',
              prefixIcon: const Icon(Icons.email_outlined),
              errorText: _emailError,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _passwordController,
            obscureText: true,
            autofillHints: const [AutofillHints.newPassword],
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_outline),
              errorText: _passwordError,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          FilledButton(
            onPressed: isLoading ? null : _submit,
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Create account'),
          ),
          const SizedBox(height: AppSpacing.sm),
          TextButton(
            onPressed: isLoading
                ? null
                : () {
                    context.go('/login');
                  },
            child: const Text('Already have an account? Sign in'),
          ),
          if (authState.hasError && authState.errorMessage != null) ...[
            const SizedBox(height: AppSpacing.md),
            Semantics(
              liveRegion: true,
              child: Text(
                authState.errorMessage!,
                style: TextStyle(color: Theme.of(context).colorScheme.error),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
