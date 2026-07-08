import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/router/app_router.dart';
import '../config/theme/app_theme.dart';
import '../features/authentication/presentation/widgets/authentication_bootstrap.dart';

class DscientiaApp extends ConsumerWidget {
  const DscientiaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'DscienTia',
      theme: AppTheme.lightTheme(),
      themeMode: ThemeMode.system,
      scrollBehavior: const MaterialScrollBehavior(),
      routerConfig: router,
      builder: (context, child) {
        return AuthenticationBootstrap(child: child ?? const SizedBox.shrink());
      },
    );
  }
}
