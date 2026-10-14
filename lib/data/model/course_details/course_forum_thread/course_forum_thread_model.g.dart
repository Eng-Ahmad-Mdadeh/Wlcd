// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_forum_thread_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseForumThreadModel _$CourseForumThreadModelFromJson(
  Map<String, dynamic> json,
) => CourseForumThreadModel(
  forumThreadId: json['forumThreadId'] as String,
  courseId: json['courseId'] as String,
  title: json['title'] as String,
  lockState: json['lockState'] as String?,
  lifecycleState: json['lifecycleState'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);
