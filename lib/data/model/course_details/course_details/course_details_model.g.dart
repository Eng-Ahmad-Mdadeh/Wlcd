// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseDetailsModel _$CourseDetailsModelFromJson(Map<String, dynamic> json) =>
    CourseDetailsModel(
      courseId: json['courseId'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      difficulty: json['difficulty'] as String,
      availableTabs: json['availableTabs'] as List<dynamic>? ?? [],
      availableActions: json['availableActions'] as List<dynamic>? ?? [],
      subtitle: json['subtitle'] as String?,
      language: json['language'] as String?,
      estimatedDurationSeconds: (json['estimatedDurationSeconds'] as num?)
          ?.toInt(),
      thumbnailMediaId: json['thumbnailMediaId'] as String?,
      thumbnail: json['thumbnail'] as Map<String, dynamic>?,
      price: json['price'] as Map<String, dynamic>?,
      raw: _readResponse(json, 'raw') as Map<String, dynamic>? ?? const {},
    );
