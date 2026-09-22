import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';

void main() {
  test('parses email verification challenge from registration response', () {
    final model = AuthModel.fromJson({
      'accessToken': 'access-token',
      'tokenType': 'Bearer',
      'expiresAt': '2026-09-22T22:20:27.510Z',
      'sessionId': 'session-id',
      'account': null,
      'effectivePermissions': <String>[],
      'emailVerification': {
        'challengeId': '01M35F9AXPR2JRA75T4CVWM562',
        'expiresAt': '2026-09-22T21:20:27.510Z',
        'cooldownSeconds': 60,
      },
    });

    expect(
      model.emailVerification?.challengeId,
      '01M35F9AXPR2JRA75T4CVWM562',
    );
    expect(
      model.emailVerification?.expiresAt,
      DateTime.parse('2026-09-22T21:20:27.510Z'),
    );
    expect(model.emailVerification?.cooldownSeconds, 60);
  });
}
