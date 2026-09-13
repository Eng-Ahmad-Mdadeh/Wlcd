import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'notification_preferences_model.g.dart';

@JsonSerializable(createToJson: false)
class NotificationPreferencesModel extends Equatable {
  const NotificationPreferencesModel({
    required this.accountId,
    required this.globalChannelPreferences,
    required this.notificationTypePreferences,
    this.localePreference,
    required this.localeProjectionSnapshot,
    required this.preferenceVersion,
    required this.initializedAt,
    required this.updatedAt,
  });

  final String accountId;
  final Map<String, dynamic> globalChannelPreferences;
  final Map<String, dynamic> notificationTypePreferences;
  final Object? localePreference;
  final String localeProjectionSnapshot;
  final int preferenceVersion;
  final DateTime initializedAt;
  final DateTime updatedAt;

  factory NotificationPreferencesModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationPreferencesModelFromJson(json);

  @override
  List<Object?> get props => [accountId, globalChannelPreferences,
    notificationTypePreferences, localePreference, localeProjectionSnapshot,
    preferenceVersion, initializedAt, updatedAt];
}
