import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/notifications/list_notifications_entity.dart';

/// Owns the current inbox query. Changing a filter always discards its cursor.
class NotificationsCubit extends Cubit<ListNotificationsEntity> {
  NotificationsCubit() : super(const ListNotificationsEntity());

  void setCursor(String? cursor) => emit(
    state.copyWith(cursor: cursor, clearCursor: cursor == null),
  );

  void setLimit(int limit) => emit(state.copyWith(limit: limit, clearCursor: true));

  void setFilters({String? category, String? readState}) => emit(
    state.copyWith(
      category: category,
      readState: readState,
      clearCategory: category == null,
      clearReadState: readState == null,
      clearCursor: true,
    ),
  );

  void reset() => emit(const ListNotificationsEntity());
}
