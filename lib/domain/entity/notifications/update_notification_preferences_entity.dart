import 'package:equatable/equatable.dart';

class UpdateNotificationPreferencesEntity extends Equatable {
  const UpdateNotificationPreferencesEntity({
    this.globalChannelPreferences = const {},
    this.notificationTypePreferences = const {},
    this.localePreference,
    required this.expectedVersion,
    this.ifMatch,
  });

  final Map<String, dynamic> globalChannelPreferences;
  final Map<String, dynamic> notificationTypePreferences;
  final Object? localePreference;
  final int expectedVersion;
  final String? ifMatch;

  UpdateNotificationPreferencesEntity copyWith({
    Map<String, dynamic>? globalChannelPreferences,
    Map<String, dynamic>? notificationTypePreferences,
    Object? localePreference,
    int? expectedVersion,
    String? ifMatch,
  }) => UpdateNotificationPreferencesEntity(
    globalChannelPreferences: globalChannelPreferences ?? this.globalChannelPreferences,
    notificationTypePreferences: notificationTypePreferences ?? this.notificationTypePreferences,
    localePreference: localePreference ?? this.localePreference,
    expectedVersion: expectedVersion ?? this.expectedVersion,
    ifMatch: ifMatch ?? this.ifMatch,
  );

  Map<String, dynamic> toJson() => {
    'globalChannelPreferences': globalChannelPreferences,
    'notificationTypePreferences': notificationTypePreferences,
    'localePreference': localePreference,
    'expectedVersion': expectedVersion,
  };

  @override
  List<Object?> get props => [
    globalChannelPreferences,
    notificationTypePreferences,
    localePreference,
    expectedVersion,
    ifMatch,
  ];
}
