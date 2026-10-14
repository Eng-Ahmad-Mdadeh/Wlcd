// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_forum_tab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseForumTabModel _$CourseForumTabModelFromJson(Map<String, dynamic> json) =>
    CourseForumTabModel(
      accessible: json['accessible'] as bool? ?? false,
      requiresAuthentication: json['requiresAuthentication'] as bool? ?? false,
      requiresEnrollment: json['requiresEnrollment'] as bool? ?? false,
      data:
          (json['data'] as List<dynamic>?)
              ?.map(
                (e) =>
                    CourseForumThreadModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          [],
    );
