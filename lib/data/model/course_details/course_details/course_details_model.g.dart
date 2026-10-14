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
      tabs: json['tabs'] == null
          ? null
          : CourseTabsModel.fromJson(json['tabs'] as Map<String, dynamic>),
      enrollmentState: json['enrollmentState'] as String?,
      commercialState: json['commercialState'] as String?,
      forumCapability: json['forumCapability'] == null
          ? null
          : CourseCapabilityModel.fromJson(
              json['forumCapability'] as Map<String, dynamic>,
            ),
      resourcesCapability: json['resourcesCapability'] == null
          ? null
          : CourseCapabilityModel.fromJson(
              json['resourcesCapability'] as Map<String, dynamic>,
            ),
      reviewsCapability: json['reviewsCapability'] == null
          ? null
          : CourseCapabilityModel.fromJson(
              json['reviewsCapability'] as Map<String, dynamic>,
            ),
      bookingCapability: json['bookingCapability'] == null
          ? null
          : CourseCapabilityModel.fromJson(
              json['bookingCapability'] as Map<String, dynamic>,
            ),
      curriculum:
          (json['curriculum'] as List<dynamic>?)
              ?.map(
                (e) => CourseCurriculumSectionModel.fromJson(
                  e as Map<String, dynamic>,
                ),
              )
              .toList() ??
          [],
    );
