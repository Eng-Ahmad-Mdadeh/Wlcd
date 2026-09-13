part of 'get_notification_preferences_bloc.dart';

sealed class IGetNotificationPreferencesState extends Equatable {
  const IGetNotificationPreferencesState();
}

final class GetNotificationPreferencesInitial extends IGetNotificationPreferencesState {
  const GetNotificationPreferencesInitial();
  @override
  List<Object?> get props => const [];
}

final class GetNotificationPreferencesLoading extends IGetNotificationPreferencesState {
  const GetNotificationPreferencesLoading();
  @override
  List<Object?> get props => const [];
}

final class GetNotificationPreferencesLoaded extends IGetNotificationPreferencesState {
  const GetNotificationPreferencesLoaded(this.preferences);
  final NotificationPreferencesModel? preferences;
  @override
  List<Object?> get props => [preferences];
}

final class GetNotificationPreferencesFailed extends IGetNotificationPreferencesState {
  const GetNotificationPreferencesFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
