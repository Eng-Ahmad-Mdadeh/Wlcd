// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'instructor_model.dart';

InstructorModel _$InstructorModelFromJson(Map<String, dynamic> json) =>
    InstructorModel(
      instructorId: json['instructorId'] as String?,
      profileSnapshotId: json['profileSnapshotId'] as String?,
      publicationVersion: (json['publicationVersion'] as num?)?.toInt(),
      displayName: json['displayName'] as String?,
      biography: json['biography'] as String?,
      specialtyCategoryIds:
          (json['specialtyCategoryIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      primarySpecialtyCategoryId:
          json['primarySpecialtyCategoryId'] as String?,
      mediaId: json['mediaId'] as String?,
      publicContactConfig: json['publicContactConfig'] == null
          ? null
          : PublicContactConfigModel.fromJson(
              json['publicContactConfig'] as Map<String, dynamic>,
            ),
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
      specialty: json['specialty'] == null
          ? null
          : InstructorSpecialtyModel.fromJson(
              json['specialty'] as Map<String, dynamic>,
            ),
      rating: (json['rating'] as num?)?.toDouble(),
      studentsCount: (json['studentsCount'] as num?)?.toInt(),
      coursesCount: (json['coursesCount'] as num?)?.toInt(),
      courses:
          (json['courses'] as List<dynamic>?)
              ?.map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      data:
          (json['data'] as List<dynamic>?)
              ?.map((e) => InstructorModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      pagination: json['pagination'] == null
          ? null
          : CatalogPaginationModel.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );
