import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/datasource/authentication_remote_datasource.dart';
import '../../data/datasource/authentication_remote_datasource_impl.dart';
import '../../data/repository/authentication_repository_impl.dart';
import '../../domain/repositories/authentication_repository.dart';

final authenticationRemoteDataSourceProvider =
    Provider<AuthenticationRemoteDataSource>((ref) {
      final dio = ref.watch(dioProvider);

      return AuthenticationRemoteDataSourceImpl(dio);
    });

final authenticationRepositoryProvider = Provider<AuthenticationRepository>((
  ref,
) {
  final remoteDataSource = ref.watch(authenticationRemoteDataSourceProvider);

  return AuthenticationRepositoryImpl(remoteDataSource);
});
