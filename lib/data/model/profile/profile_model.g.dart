// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MediaProjectionModel _$MediaProjectionModelFromJson(
  Map<String, dynamic> json,
) => MediaProjectionModel(
  url: json['url'] as String?,
  mimeType: json['mimeType'] as String?,
  altText: json['altText'] as String?,
);

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  accountId: json['accountId'] as String,
  displayName: json['displayName'] as String,
  status: json['status'] as String,
  profileComplete: json['profileComplete'] as bool,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  locale: json['locale'] as String?,
  avatarMediaId: json['avatarMediaId'] as String?,
  avatar: json['avatar'] == null
      ? null
      : MediaProjectionModel.fromJson(json['avatar'] as Map<String, dynamic>),
  onboardingComplete: json['onboardingComplete'] as bool?,
  version: (json['version'] as num?)?.toInt(),
  etag: json['etag'] as String?,
);
