import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/course_details/course_curriculum_tab/course_curriculum_tab_model.dart';
import 'package:wlcd/data/model/course_details/course_forum_tab/course_forum_tab_model.dart';
import 'package:wlcd/data/model/course_details/course_overview/course_overview_model.dart';
import 'package:wlcd/data/model/course_details/course_resources_tab/course_resources_tab_model.dart';
import 'package:wlcd/data/model/course_details/course_reviews_tab/course_reviews_tab_model.dart';

part 'course_tabs_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseTabsModel extends Equatable {
  const CourseTabsModel({
    this.overview,
    this.curriculum,
    this.reviews,
    this.forum,
    this.resources,
    this.downloads,
  });

  final CourseOverviewModel? overview;
  final CourseCurriculumTabModel? curriculum;
  final CourseReviewsTabModel? reviews;
  final CourseForumTabModel? forum;
  final CourseResourcesTabModel? resources;
  final CourseResourcesTabModel? downloads;

  factory CourseTabsModel.fromJson(Map<String, dynamic> json) =>
      _$CourseTabsModelFromJson(json);

  @override
  List<Object?> get props => [
    overview,
    curriculum,
    reviews,
    forum,
    resources,
    downloads,
  ];
}
