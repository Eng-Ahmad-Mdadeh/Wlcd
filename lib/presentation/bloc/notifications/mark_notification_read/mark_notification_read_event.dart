part of 'mark_notification_read_bloc.dart';

sealed class IMarkNotificationReadEvent extends Equatable {
  const IMarkNotificationReadEvent();
}

final class MarkNotificationReadEvent extends IMarkNotificationReadEvent {
  const MarkNotificationReadEvent(this.entity);

  final NotificationCommandEntity entity;

  @override
  List<Object?> get props => [entity];
}
