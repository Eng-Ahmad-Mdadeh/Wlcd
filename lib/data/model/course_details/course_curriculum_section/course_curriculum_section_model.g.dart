// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_curriculum_section_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCurriculumSectionModel _$CourseCurriculumSectionModelFromJson(
  Map<String, dynamic> json,
) => CourseCurriculumSectionModel(
  sectionId: json['sectionId'] as String,
  title: json['title'] as String,
  displayOrder: (json['displayOrder'] as num?)?.toInt() ?? 0,
  lessons:
      (json['lessons'] as List<dynamic>?)
          ?.map(
            (e) =>
                CourseCurriculumLessonModel.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      [],
);
