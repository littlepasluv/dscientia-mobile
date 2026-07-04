import 'package:flutter/material.dart';

import '../config/router/app_router.dart';
import '../config/theme/app_theme.dart';

class DscientiaApp extends StatelessWidget {
  const DscientiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,

      title: 'DscienTia',

      theme: AppTheme.lightTheme(),

      themeMode: ThemeMode.system,

      scrollBehavior: const MaterialScrollBehavior(),

      routerConfig: appRouter,

      builder: (context, child) {
        return child!;
      },
    );
  }
}