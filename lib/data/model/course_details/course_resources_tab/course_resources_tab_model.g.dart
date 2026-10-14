// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_resources_tab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseResourcesTabModel _$CourseResourcesTabModelFromJson(
  Map<String, dynamic> json,
) => CourseResourcesTabModel(
  accessible: json['accessible'] as bool? ?? false,
  requiresAuthentication: json['requiresAuthentication'] as bool? ?? false,
  requiresEnrollment: json['requiresEnrollment'] as bool? ?? false,
  resourceCount: (json['resourceCount'] as num?)?.toInt() ?? 0,
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => CourseResourceModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);
