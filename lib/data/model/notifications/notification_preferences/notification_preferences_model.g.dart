// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_preferences_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationPreferencesModel _$NotificationPreferencesModelFromJson(
  Map<String, dynamic> json,
) => NotificationPreferencesModel(
  accountId: json['accountId'] as String,
  globalChannelPreferences:
      json['globalChannelPreferences'] as Map<String, dynamic>,
  notificationTypePreferences:
      json['notificationTypePreferences'] as Map<String, dynamic>,
  localePreference: json['localePreference'],
  localeProjectionSnapshot: json['localeProjectionSnapshot'] as String,
  preferenceVersion: (json['preferenceVersion'] as num).toInt(),
  initializedAt: DateTime.parse(json['initializedAt'] as String),
  updatedAt: DateTime.parse(json['updatedAt'] as String),
);
