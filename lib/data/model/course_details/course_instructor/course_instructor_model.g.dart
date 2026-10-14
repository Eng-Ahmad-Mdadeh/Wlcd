// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_instructor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseInstructorModel _$CourseInstructorModelFromJson(
  Map<String, dynamic> json,
) => CourseInstructorModel(
  instructorId: json['instructorId'] as String,
  displayName: json['displayName'] as String,
  headline: json['headline'] as String?,
  avatarMediaId: json['avatarMediaId'] as String?,
  avatar: json['avatar'] == null
      ? null
      : CourseThumbnailModel.fromJson(json['avatar'] as Map<String, dynamic>),
);
