// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_capability_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCapabilityModel _$CourseCapabilityModelFromJson(
  Map<String, dynamic> json,
) => CourseCapabilityModel(
  available: json['available'] as bool? ?? false,
  requiresAuthentication: json['requiresAuthentication'] as bool? ?? false,
  requiresEnrollment: json['requiresEnrollment'] as bool? ?? false,
  resourceCount: (json['resourceCount'] as num?)?.toInt(),
  reviewCount: (json['reviewCount'] as num?)?.toInt(),
  instructorId: json['instructorId'] as String?,
);
