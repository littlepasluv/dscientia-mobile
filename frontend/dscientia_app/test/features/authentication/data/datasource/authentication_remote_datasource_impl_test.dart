import 'package:dio/dio.dart';
import 'package:dscientia_app/features/authentication/data/datasource/authentication_remote_datasource_impl.dart';
import 'package:dscientia_app/features/authentication/data/models/user_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthenticationRemoteDataSourceImpl', () {
    test('parses the current-session response as a user', () async {
      final dio = Dio();

      dio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            expect(options.method, 'GET');
            expect(options.path, '/auth/session');

            handler.resolve(
              Response<dynamic>(
                requestOptions: options,
                statusCode: 200,
                data: {
                  'data': {
                    'user': {
                      'id': '1',
                      'email': 'session@example.com',
                      'full_name': 'Session User',
                      'role': 'community_leader',
                      'is_email_verified': true,
                      'created_at': '2026-08-07T12:00:00.000Z',
                    },
                  },
                },
              ),
            );
          },
        ),
      );

      final dataSource = AuthenticationRemoteDataSourceImpl(dio);

      final result = await dataSource.getCurrentSession();

      expect(
        result,
        isA<UserModel>()
            .having((user) => user.id, 'id', '1')
            .having((user) => user.fullName, 'fullName', 'Session User')
            .having((user) => user.email, 'email', 'session@example.com')
            .having((user) => user.role, 'role', 'community_leader')
            .having((user) => user.isEmailVerified, 'isEmailVerified', true)
            .having(
              (user) => user.createdAt,
              'createdAt',
              DateTime.utc(2026, 8, 7, 12),
            ),
      );
    });

    test(
      'returns null when the current-session endpoint responds with 401',
      () async {
        final dio = Dio();

        dio.interceptors.add(
          InterceptorsWrapper(
            onRequest: (options, handler) {
              expect(options.method, 'GET');
              expect(options.path, '/auth/session');

              handler.reject(
                DioException(
                  requestOptions: options,
                  response: Response<dynamic>(
                    requestOptions: options,
                    statusCode: 401,
                    data: {'message': 'Unauthenticated.'},
                  ),
                  type: DioExceptionType.badResponse,
                ),
              );
            },
          ),
        );

        final dataSource = AuthenticationRemoteDataSourceImpl(dio);

        final result = await dataSource.getCurrentSession();

        expect(result, isNull);
      },
    );
  });
}
