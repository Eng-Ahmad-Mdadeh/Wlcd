// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SessionModel _$SessionModelFromJson(Map<String, dynamic> json) => SessionModel(
  sessionId: json['sessionId'] as String?,
  accountId: json['accountId'] as String?,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  authMethod: json['authMethod'] as String?,
  account: json['account'] == null
      ? null
      : AuthAccountModel.fromJson(json['account'] as Map<String, dynamic>),
  profileComplete: json['profileComplete'] as bool?,
  onboardingComplete: json['onboardingComplete'] as bool?,
  effectivePermissions: (json['effectivePermissions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);
