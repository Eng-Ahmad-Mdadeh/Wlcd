import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/notifications/notification/notification_model.dart';
import 'package:wlcd/data/model/pagination/pagination_model.dart';

void main() {
  test('parses the documented notifications response', () {
    final model = PaginationModel<NotificationModel>.fromJson({
      'data': [
        {
          'notificationId': '01HXYZABCDEFGHJKMNPQRSTVWX',
          'notificationType': 'string',
          'category': 'Transactional',
          'readState': 'Unread',
          'deliveryState': 'Pending',
          'title': 'string',
          'body': 'string',
          'navigationTarget': {
            'targetType': 'course',
            'targetId': '01HXYZABCDEFGHJKMNPQRSTVWA',
            'action': 'view',
          },
          'createdAt': '2026-09-13T21:13:19.310Z',
          'version': 0,
        },
      ],
      'pagination': {
        'nextCursor': 'string',
        'previousCursor': 'string',
        'hasMore': true,
        'limit': 1,
      },
    }, (item) => NotificationModel.fromJson(item as Map<String, dynamic>));

    expect(model.data!.single.notificationId, '01HXYZABCDEFGHJKMNPQRSTVWX');
    expect(model.data!.single.navigationTarget?.targetType, 'course');
    expect(model.data!.single.createdAt.isUtc, isTrue);
    expect(model.nextCursor, 'string');
    expect(model.hasMore, isTrue);
    expect(model.limit, 1);
  });

  test('keeps supporting the existing page pagination shape', () {
    final model = PaginationModel<String>.fromJson({
      'current_page': 1,
      'data': ['notification'],
      'from': 1,
      'last_page': 1,
      'per_page': 10,
      'to': 1,
      'total': 1,
      'meta': {'next_cursor': null},
    }, (item) => item! as String);

    expect(model.currentPage, 1);
    expect(model.data, ['notification']);
    expect(model.meta?.nextCursor, isNull);
  });
}
