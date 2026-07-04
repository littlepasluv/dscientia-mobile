import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../app_config.dart';
import '../env/environment.dart';

final appConfigProvider = Provider<AppConfig>((ref) {
  return const AppConfig(
    environment: Environment.development,
  );
});
