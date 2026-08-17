// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_thumbnail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseThumbnailModel _$CourseThumbnailModelFromJson(
  Map<String, dynamic> json,
) => CourseThumbnailModel(
  mediaId: json['mediaId'] as String,
  url: json['url'] as String,
  deliveryType: json['deliveryType'] as String,
  mimeType: json['mimeType'] as String,
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  cachePolicy: json['cachePolicy'] as String,
  fileName: json['fileName'] as String,
  sizeBytes: (json['sizeBytes'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
);
