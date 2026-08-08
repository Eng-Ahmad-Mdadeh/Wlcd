import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/auth/verify_email_model.dart';
import 'package:wlcd/data/model/auth/phone_otp_challenge_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';
import 'package:wlcd/domain/entity/auth/register_with_phone_entity.dart';
import 'package:wlcd/domain/entity/auth/verify_email_entity.dart';
import 'package:wlcd/domain/entity/auth/request_phone_otp_entity.dart';
import 'package:wlcd/data/model/auth/phone_otp_verification_model.dart';
import 'package:wlcd/data/model/auth/operation_success_model.dart';
import 'package:wlcd/domain/entity/auth/verify_phone_otp_entity.dart';
import 'package:wlcd/domain/entity/auth/login_with_password_entity.dart';
import 'package:wlcd/domain/entity/auth/request_login_otp_entity.dart';
import 'package:wlcd/domain/entity/auth/login_with_otp_entity.dart';
import 'package:wlcd/domain/entity/auth/request_password_reset_entity.dart';
import 'package:wlcd/domain/entity/auth/reset_password_entity.dart';


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

  test('VerifyEmailEntity serializes the verification request', () {
    const entity = VerifyEmailEntity(
      token: 'email-verification-token',
      challengeId: '01HXYZABCDEFGHJKMNPQRSTVWX',
    );

    expect(entity.toJson(), {
      'token': 'email-verification-token',
      'challengeId': '01HXYZABCDEFGHJKMNPQRSTVWX',
    });
  });

  test('VerifyEmailModel parses the verification response', () {
    final model = VerifyEmailModel.fromJson({
      'verified': true,
      'accountId': '01HXYZABCDEFGHJKMNPQRSTVWX',
    });

    expect(model.verified, isTrue);
    expect(model.accountId, '01HXYZABCDEFGHJKMNPQRSTVWX');
  });

  test('RequestPhoneOtpEntity serializes the OTP request', () {
    const entity = RequestPhoneOtpEntity(
      phone: '+966550000000',
      purpose: 'Register',
    );

    expect(entity.toJson(), {
      'phone': '+966550000000',
      'purpose': 'Register',
    });
  });

  test('PhoneOtpChallengeModel parses the OTP challenge response', () {
    final model = PhoneOtpChallengeModel.fromJson({
      'challengeId': '01HXYZABCDEFGHJKMNPQRSTVWX',
      'expiresAt': '2026-08-01T12:00:00.000Z',
      'cooldownSeconds': 30,
    });

    expect(model.challengeId, '01HXYZABCDEFGHJKMNPQRSTVWX');
    expect(model.expiresAt, DateTime.utc(2026, 8, 1, 12));
    expect(model.cooldownSeconds, 30);
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
  test('new authentication requests serialize bodies and headers', () {
    const verifyOtp = VerifyPhoneOtpEntity(challengeId: 'challenge', otpCode: '123456');
    const passwordLogin = LoginWithPasswordEntity(email: 'user@example.com', password: 'secret', rememberMe: true, idempotencyKey: 'login-key');
    const requestLoginOtp = RequestLoginOtpEntity(phone: '+966550000000');
    const otpLogin = LoginWithOtpEntity(challengeId: 'challenge', otpCode: '123456', rememberMe: false, idempotencyKey: 'otp-key');
    const resetRequest = RequestPasswordResetEntity(email: 'user@example.com');
    const reset = ResetPasswordEntity(token: 'token', newPassword: 'new-secret', idempotencyKey: 'reset-key');

    expect(verifyOtp.toJson(), {'challengeId': 'challenge', 'otpCode': '123456'});
    expect(passwordLogin.toJson(), {'email': 'user@example.com', 'password': 'secret', 'rememberMe': true});
    expect(passwordLogin.headers, {'Idempotency-Key': 'login-key'});
    expect(requestLoginOtp.toJson(), {'phone': '+966550000000'});
    expect(otpLogin.toJson(), {'challengeId': 'challenge', 'otpCode': '123456', 'rememberMe': false});
    expect(otpLogin.headers, {'Idempotency-Key': 'otp-key'});
    expect(resetRequest.toJson(), {'email': 'user@example.com'});
    expect(reset.toJson(), {'token': 'token', 'newPassword': 'new-secret'});
    expect(reset.headers, {'Idempotency-Key': 'reset-key'});
  });

  test('OTP verification and generic success responses parse', () {
    final verification = PhoneOtpVerificationModel.fromJson({'verified': true, 'challengeId': 'challenge'});
    final success = OperationSuccessModel.fromJson({'success': true});
    expect(verification.verified, isTrue);
    expect(verification.challengeId, 'challenge');
    expect(success.success, isTrue);
  });

}
