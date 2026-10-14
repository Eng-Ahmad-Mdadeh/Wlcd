// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'curriculum_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CurriculumModel _$CurriculumModelFromJson(Map<String, dynamic> json) =>
    CurriculumModel(
      courseId: json['courseId'] as String,
      enrollmentId: json['enrollmentId'] as String,
      enrolledPublishedRevisionId:
          json['enrolledPublishedRevisionId'] as String,
      learningStatus: json['learningStatus'] as String,
      completionPercentage: (json['completionPercentage'] as num).toInt(),
      sections: json['sections'] as List<dynamic>? ?? [],
      courseTitle: json['courseTitle'] as String?,
      lastAccessedLessonId: json['lastAccessedLessonId'] as String?,
    );
