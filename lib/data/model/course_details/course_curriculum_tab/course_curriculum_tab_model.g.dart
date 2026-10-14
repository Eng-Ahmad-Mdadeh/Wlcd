// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_curriculum_tab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseCurriculumTabModel _$CourseCurriculumTabModelFromJson(
  Map<String, dynamic> json,
) => CourseCurriculumTabModel(
  data:
      (json['data'] as List<dynamic>?)
          ?.map(
            (e) => CourseCurriculumSectionModel.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList() ??
      [],
);
