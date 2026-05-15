// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String?,
  stableName: json['stable_name'] as String?,
  name: json['name'] as String?,
  email: json['email'],
  phone: json['phone'] as String?,
  gender: json['gender'],
  countryId: json['country_id'],
  emailVerifiedAt: json['email_verified_at'],
  deletedAt: json['deleted_at'],
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
  profileComplete: json['profile_complete'] as bool?,
  country: json['country'] as String?,
  state: json['state'] as String?,
  purchaseDate: json['purchase_date'] as String?,
);
