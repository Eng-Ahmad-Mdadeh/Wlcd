// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_state_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LearningStateModel _$LearningStateModelFromJson(
  Map<String, dynamic> json,
) => LearningStateModel(
  enrollmentId: json['enrollmentId'] as String,
  courseId: json['courseId'] as String,
  enrolledPublishedRevisionId: json['enrolledPublishedRevisionId'] as String,
  learningStatus: json['learningStatus'] as String,
  completedLessonCount: (json['completedLessonCount'] as num).toInt(),
  totalRequiredLessonCount: (json['totalRequiredLessonCount'] as num).toInt(),
  completionPercentage: (json['completionPercentage'] as num).toInt(),
  lastAccessedLessonId: json['lastAccessedLessonId'] as String?,
  completedAt: json['completedAt'] == null
      ? null
      : DateTime.parse(json['completedAt'] as String),
);
