// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthModel _$AuthModelFromJson(Map<String, dynamic> json) => AuthModel(
  accessToken: json['accessToken'] as String?,
  tokenType: json['tokenType'] as String?,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  sessionId: json['sessionId'] as String?,
  account: json['account'] == null
      ? null
      : AuthAccountModel.fromJson(json['account'] as Map<String, dynamic>),
  effectivePermissions: (json['effectivePermissions'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

AuthAccountModel _$AuthAccountModelFromJson(Map<String, dynamic> json) =>
    AuthAccountModel(
      accountId: json['accountId'] as String?,
      status: json['status'] as String?,
      profileComplete: json['profileComplete'] as bool?,
      displayName: json['displayName'] as String?,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      onboardingComplete: json['onboardingComplete'] as bool?,
    );
