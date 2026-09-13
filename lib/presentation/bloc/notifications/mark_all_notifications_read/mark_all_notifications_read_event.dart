part of 'mark_all_notifications_read_bloc.dart';

sealed class IMarkAllNotificationsReadEvent extends Equatable {
  const IMarkAllNotificationsReadEvent();
}

final class MarkAllNotificationsReadEvent extends IMarkAllNotificationsReadEvent {
  const MarkAllNotificationsReadEvent();


  @override
  List<Object?> get props => const [];
}
