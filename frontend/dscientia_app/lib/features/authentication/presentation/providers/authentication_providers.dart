import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../../../core/storage/secure_storage_provider.dart';
import '../../data/datasource/authentication_local_datasource.dart';
import '../../data/datasource/authentication_local_datasource_impl.dart';
import '../../data/datasource/authentication_remote_datasource.dart';
import '../../data/datasource/authentication_remote_datasource_impl.dart';
import '../../data/repository/authentication_repository_impl.dart';
import '../../domain/repositories/authentication_repository.dart';

final authenticationRemoteDataSourceProvider =
    Provider<AuthenticationRemoteDataSource>((ref) {
      final dio = ref.watch(dioProvider);

      return AuthenticationRemoteDataSourceImpl(dio);
    });

final authenticationLocalDataSourceProvider =
    Provider<AuthenticationLocalDataSource>((ref) {
      final secureStorage = ref.watch(secureStorageProvider);

      return AuthenticationLocalDataSourceImpl(secureStorage);
    });

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(authenticationRemoteDataSourceProvider);

  final localDataSource = ref.watch(authenticationLocalDataSourceProvider);

  return AuthenticationRepositoryImpl(remoteDataSource, localDataSource);
});
