import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/presentation/cubit/notifications/notifications_cubit.dart';

void main() {
  test('changing filters resets the opaque cursor', () {
    final cubit = NotificationsCubit();
    addTearDown(cubit.close);

    cubit.setCursor('opaque-cursor');
    cubit.setFilters(category: 'Transactional', readState: 'Unread');

    expect(cubit.state.cursor, isNull);
    expect(cubit.state.category, 'Transactional');
    expect(cubit.state.readState, 'Unread');
  });
}
