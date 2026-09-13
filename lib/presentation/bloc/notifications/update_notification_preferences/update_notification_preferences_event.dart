part of 'update_notification_preferences_bloc.dart';

sealed class IUpdateNotificationPreferencesEvent extends Equatable {
  const IUpdateNotificationPreferencesEvent();
}

final class UpdateNotificationPreferencesEvent extends IUpdateNotificationPreferencesEvent {
  const UpdateNotificationPreferencesEvent(this.entity);

  final UpdateNotificationPreferencesEntity entity;

  @override
  List<Object?> get props => [entity];
}
