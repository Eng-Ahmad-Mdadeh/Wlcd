import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/notifications/update_notification_preferences_entity.dart';

/// Stores the editable preferences entity until the user submits one intent.
class NotificationPreferencesCubit
    extends Cubit<UpdateNotificationPreferencesEntity> {
  NotificationPreferencesCubit(UpdateNotificationPreferencesEntity initial)
    : super(initial);

  void setGlobalChannelPreferences(Map<String, dynamic> value) => emit(
    state.copyWith(globalChannelPreferences: value),
  );

  void setNotificationTypePreferences(Map<String, dynamic> value) => emit(
    state.copyWith(notificationTypePreferences: value),
  );

  void setLocalePreference(Object? value) => emit(
    UpdateNotificationPreferencesEntity(
      globalChannelPreferences: state.globalChannelPreferences,
      notificationTypePreferences: state.notificationTypePreferences,
      localePreference: value,
      expectedVersion: state.expectedVersion,
      ifMatch: state.ifMatch,
    ),
  );
}
