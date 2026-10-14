// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_curriculum_lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCurriculumLessonModel _$CourseCurriculumLessonModelFromJson(
  Map<String, dynamic> json,
) => CourseCurriculumLessonModel(
  lessonId: json['lessonId'] as String,
  title: json['title'] as String,
  lessonType: json['lessonType'] as String,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  durationEstimateSeconds: (json['durationEstimateSeconds'] as num?)?.toInt(),
  isPreviewEligible: json['isPreviewEligible'] as bool? ?? false,
);
