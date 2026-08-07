import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/env/dscientia_api_config.dart';
import '../storage/secure_storage_provider.dart';
import 'auth_interceptor.dart';

final dioProvider = Provider((ref) {
  final secureStorage = ref.watch(secureStorageProvider);

  final dio = Dio(
    BaseOptions(
      baseUrl: DscientiaApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
    ),
  );

  dio.interceptors.add(AuthInterceptor(secureStorage));

  return dio;
});
