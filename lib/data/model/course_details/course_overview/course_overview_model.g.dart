// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_overview_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseOverviewModel _$CourseOverviewModelFromJson(Map<String, dynamic> json) =>
    CourseOverviewModel(
      description: json['description'] as String,
      subtitle: json['subtitle'] as String?,
      language: json['language'] as String?,
      difficulty: json['difficulty'] as String?,
      estimatedDurationSeconds: (json['estimatedDurationSeconds'] as num?)
          ?.toInt(),
      thumbnail: json['thumbnail'] == null
          ? null
          : CourseThumbnailModel.fromJson(
              json['thumbnail'] as Map<String, dynamic>,
            ),
      instructor: json['instructor'] == null
          ? null
          : CourseInstructorModel.fromJson(
              json['instructor'] as Map<String, dynamic>,
            ),
      price: json['price'] == null
          ? null
          : CoursePriceModel.fromJson(json['price'] as Map<String, dynamic>),
    );
