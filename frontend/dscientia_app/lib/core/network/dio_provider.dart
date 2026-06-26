import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../config/app_config.dart';
import '../config/environment.dart';

final dioProvider = Provider<Dio>((ref) {
final config = AppConfig(
environment: Environment.development,
);

return Dio(
BaseOptions(
baseUrl: config.apiBaseUrl,
connectTimeout: const Duration(seconds: 30),
receiveTimeout: const Duration(seconds: 30),
),
);
});
