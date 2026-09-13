// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'notification_preferences_model.dart';

NotificationPreferencesModel _$NotificationPreferencesModelFromJson(Map<String, dynamic> json) =>
    NotificationPreferencesModel(
      accountId: json['accountId'] as String,
      globalChannelPreferences: Map<String, dynamic>.from(json['globalChannelPreferences'] as Map),
      notificationTypePreferences: Map<String, dynamic>.from(json['notificationTypePreferences'] as Map),
      localePreference: json['localePreference'],
      localeProjectionSnapshot: json['localeProjectionSnapshot'] as String,
      preferenceVersion: (json['preferenceVersion'] as num).toInt(),
      initializedAt: DateTime.parse(json['initializedAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
    );
