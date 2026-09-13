part of 'get_notification_preferences_bloc.dart';

sealed class IGetNotificationPreferencesEvent extends Equatable {
  const IGetNotificationPreferencesEvent();
}

final class LoadNotificationPreferencesEvent extends IGetNotificationPreferencesEvent {
  const LoadNotificationPreferencesEvent();


  @override
  List<Object?> get props => const [];
}
