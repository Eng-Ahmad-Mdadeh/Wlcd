// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_resource_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResourceModel _$CourseResourceModelFromJson(Map<String, dynamic> json) =>
    CourseResourceModel(
      resourceId: json['resourceId'] as String,
      title: json['title'] as String,
      resourceType: json['resourceType'] as String,
      fileSizeBytes: (json['fileSizeBytes'] as num?)?.toInt(),
      displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
    );
