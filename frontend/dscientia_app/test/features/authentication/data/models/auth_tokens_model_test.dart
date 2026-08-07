import 'package:dscientia_app/features/authentication/data/models/auth_tokens_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthTokensModel', () {
    test('parses Sanctum response without a refresh token', () {
      final model = AuthTokensModel.fromJson({
        'access_token': '1|test-access-token',
        'expires_at': '2026-08-14T16:00:00.000Z',
      });

      expect(model.accessToken, '1|test-access-token');
      expect(model.expiresAt, DateTime.utc(2026, 8, 14, 16));
    });
    test('maps the model to an AuthTokens entity', () {
      final model = AuthTokensModel(
        accessToken: '1|test-access-token',
        expiresAt: DateTime.utc(2026, 8, 14, 16),
      );

      final entity = model.toEntity();

      expect(entity.accessToken, model.accessToken);
      expect(entity.expiresAt, model.expiresAt);
    });
  });
}
