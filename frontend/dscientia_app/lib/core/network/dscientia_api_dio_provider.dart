import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../config/env/dscientia_api_config.dart';

final dscientiaApiDioProvider = Provider<Dio>((ref) {
  return Dio(
    BaseOptions(
      baseUrl: DscientiaApiConfig.baseUrl,
      connectTimeout: const Duration(seconds: 10),
      receiveTimeout: const Duration(seconds: 20),
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
    ),
  );
});
