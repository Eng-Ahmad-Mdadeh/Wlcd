part of 'update_notification_preferences_bloc.dart';

sealed class IUpdateNotificationPreferencesState extends Equatable {
  const IUpdateNotificationPreferencesState();
}

final class UpdateNotificationPreferencesInitial extends IUpdateNotificationPreferencesState {
  const UpdateNotificationPreferencesInitial();
  @override
  List<Object?> get props => const [];
}

final class UpdateNotificationPreferencesLoading extends IUpdateNotificationPreferencesState {
  const UpdateNotificationPreferencesLoading();
  @override
  List<Object?> get props => const [];
}

final class UpdateNotificationPreferencesLoaded extends IUpdateNotificationPreferencesState {
  const UpdateNotificationPreferencesLoaded(this.preferences);
  final NotificationPreferencesModel? preferences;
  @override
  List<Object?> get props => [preferences];
}

final class UpdateNotificationPreferencesFailed extends IUpdateNotificationPreferencesState {
  const UpdateNotificationPreferencesFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
