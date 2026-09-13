part of 'get_notification_bloc.dart';

sealed class IGetNotificationEvent extends Equatable {
  const IGetNotificationEvent();
}

final class LoadNotificationEvent extends IGetNotificationEvent {
  const LoadNotificationEvent(this.entity);

  final NotificationCommandEntity entity;

  @override
  List<Object?> get props => [entity];
}
