// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'courses_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoursesModel _$CoursesModelFromJson(Map<String, dynamic> json) => CoursesModel(
  data: (json['data'] as List<dynamic>)
      .map((e) => CourseModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  pagination: json['pagination'] == null
      ? null
      : CatalogPaginationModel.fromJson(
          json['pagination'] as Map<String, dynamic>,
        ),
);
