import 'package:flutter/widgets.dart';

class AppBootstrap {
  const AppBootstrap._();

  static Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    await _initializeCore();
  }

  static Future<void> _initializeCore() async {
    // Environment
    // Logger
    // Secure Storage
    // Hive
    // Firebase
    //
    // These services will be initialized incrementally
    // in future foundation sprints.
  }
}
