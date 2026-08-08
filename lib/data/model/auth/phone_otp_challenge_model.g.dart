// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'phone_otp_challenge_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PhoneOtpChallengeModel _$PhoneOtpChallengeModelFromJson(
  Map<String, dynamic> json,
) => PhoneOtpChallengeModel(
  challengeId: json['challengeId'] as String?,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  cooldownSeconds: (json['cooldownSeconds'] as num?)?.toInt(),
);
