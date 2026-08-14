import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/update_profile_entity.dart';

void main() {
  group('profile contract', () {
    test('update intent keeps idempotency and concurrency headers out of body', () {
      const intent = UpdateProfileEntity(
        displayName: 'Learner',
        idempotencyKey: 'intent-1',
        ifMatch: '"7"',
      );

      expect(intent.toJson(), {'displayName': 'Learner'});
      expect(intent.headers, {
        'Idempotency-Key': 'intent-1',
        'If-Match': '"7"',
      });
    });

    test('profile reads the server media projection URL', () {
      final profile = ProfileModel.fromJson({
        'accountId': '01ACCOUNT',
        'displayName': 'Learner',
        'status': 'active',
        'profileComplete': true,
        'avatar': {'url': 'https://cdn.example/avatar.jpg'},
      });

      expect(profile.accountId, '01ACCOUNT');
      expect(profile.avatar?.url, 'https://cdn.example/avatar.jpg');
      expect(profile.email, isNull);
    });
  });
}
