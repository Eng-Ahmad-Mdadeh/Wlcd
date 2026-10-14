// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonModel _$LessonModelFromJson(Map<String, dynamic> json) => LessonModel(
  courseId: json['courseId'] as String,
  lessonId: json['lessonId'] as String,
  enrolledPublishedRevisionId: json['enrolledPublishedRevisionId'] as String,
  title: json['title'] as String,
  lessonType: json['lessonType'] as String,
  completionExpectation: json['completionExpectation'] as String,
  description: json['description'] as String?,
  contentDurationSeconds: (json['contentDurationSeconds'] as num?)?.toInt(),
  mediaReferenceId: json['mediaReferenceId'] as String?,
);
