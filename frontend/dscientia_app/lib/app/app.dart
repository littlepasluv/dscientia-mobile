import 'package:flutter/material.dart';

import '../core/theme/app_theme.dart';
import '../routes/app_router.dart';

class DscientiaApp extends StatelessWidget {
const DscientiaApp({super.key});

@override
Widget build(BuildContext context) {
return MaterialApp.router(
debugShowCheckedModeBanner: false,
title: 'DscienTia',
theme: AppTheme.lightTheme(),
routerConfig: appRouter,
);
}
}
