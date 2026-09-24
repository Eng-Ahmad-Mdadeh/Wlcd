// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'public_contact_config_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PublicContactChannelModel _$PublicContactChannelModelFromJson(
  Map<String, dynamic> json,
) => PublicContactChannelModel(
  type: json['type'] as String?,
  value: json['value'] as String?,
);

PublicContactConfigModel _$PublicContactConfigModelFromJson(
  Map<String, dynamic> json,
) => PublicContactConfigModel(
  channels:
      (json['channels'] as List<dynamic>?)
          ?.map(
            (e) =>
                PublicContactChannelModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);
