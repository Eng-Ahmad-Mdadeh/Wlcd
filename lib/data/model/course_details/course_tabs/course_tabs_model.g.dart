// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_tabs_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseTabsModel _$CourseTabsModelFromJson(
  Map<String, dynamic> json,
) => CourseTabsModel(
  overview: json['overview'] == null
      ? null
      : CourseOverviewModel.fromJson(json['overview'] as Map<String, dynamic>),
  curriculum: json['curriculum'] == null
      ? null
      : CourseCurriculumTabModel.fromJson(
          json['curriculum'] as Map<String, dynamic>,
        ),
  reviews: json['reviews'] == null
      ? null
      : CourseReviewsTabModel.fromJson(json['reviews'] as Map<String, dynamic>),
  forum: json['forum'] == null
      ? null
      : CourseForumTabModel.fromJson(json['forum'] as Map<String, dynamic>),
  resources: json['resources'] == null
      ? null
      : CourseResourcesTabModel.fromJson(
          json['resources'] as Map<String, dynamic>,
        ),
  downloads: json['downloads'] == null
      ? null
      : CourseResourcesTabModel.fromJson(
          json['downloads'] as Map<String, dynamic>,
        ),
);
