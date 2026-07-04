import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../env/environment.dart';
import '../app_config.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  const envName = String.fromEnvironment('APP_ENV');

  final env = Environment.values.firstWhere(
    (e) => e.name == envName,
    orElse: () => Environment.production,
  );

  return AppConfig(
    environment: env,
  );
});
