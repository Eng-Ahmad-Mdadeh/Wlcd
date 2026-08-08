import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';
import 'package:wlcd/domain/entity/auth/register_with_phone_entity.dart';

void main() {
  group('RegisterWithEmailEntity', () {
    const entity = RegisterWithEmailEntity(
      displayName: 'Test User',
      email: 'user@example.com',
      password: 'secret-password',
      locale: 'en',
      idempotencyKey: 'registration-1',
      correlationId: 'journey-1',
    );

    test('serializes request body separately from workflow headers', () {
      expect(entity.toJson(), {
        'displayName': 'Test User',
        'email': 'user@example.com',
        'password': 'secret-password',
        'locale': 'en',
      });
      expect(entity.headers, {
        'Idempotency-Key': 'registration-1',
        'X-Correlation-ID': 'journey-1',
      });
    });
  });

  group('RegisterWithPhoneEntity', () {
    const entity = RegisterWithPhoneEntity(
      phone: '+966550000000',
      challengeId: '01HXYZABCDEFGHJKMNPQRSTVWX',
      otpCode: '123456',
      locale: 'ar',
      idempotencyKey: 'phone-registration-1',
    );

    test('serializes request body separately from idempotency header', () {
      expect(entity.toJson(), {
        'phone': '+966550000000',
        'challengeId': '01HXYZABCDEFGHJKMNPQRSTVWX',
        'otpCode': '123456',
        'locale': 'ar',
      });
      expect(entity.headers, {
        'Idempotency-Key': 'phone-registration-1',
      });
    });
  });

  test('AuthModel parses the registration session response', () {
    final model = AuthModel.fromJson({
      'tokenType': 'Bearer',
      'expiresAt': '2026-08-01T12:00:00.000Z',
      'sessionId': '01HXYZABCDEFGHJKMNPQRSTVWX',
      'account': {
        'accountId': '01HXYZABCDEFGHJKMNPQRSTVWX',
        'status': 'PendingVerification',
        'profileComplete': true,
      },
      'effectivePermissions': ['PERM-512'],
    });

    expect(model.tokenType, 'Bearer');
    expect(model.expiresAt, DateTime.utc(2026, 8, 1, 12));
    expect(model.sessionId, '01HXYZABCDEFGHJKMNPQRSTVWX');
    expect(model.account?.status, 'PendingVerification');
    expect(model.account?.profileComplete, isTrue);
    expect(model.effectivePermissions, ['PERM-512']);
  });
}
