import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/course_details/course_capability/course_capability_model.dart';
import 'package:wlcd/data/model/course_details/course_curriculum_section/course_curriculum_section_model.dart';
import 'package:wlcd/data/model/course_details/course_tabs/course_tabs_model.dart';

part 'course_details_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseDetailsModel extends Equatable {
  const CourseDetailsModel({
    required this.courseId,
    required this.title,
    required this.description,
    required this.difficulty,
    required this.availableTabs,
    required this.availableActions,
    this.subtitle,
    this.language,
    this.estimatedDurationSeconds,
    this.thumbnailMediaId,
    this.thumbnail,
    this.price,
    this.raw = const {},
    this.tabs,
    this.enrollmentState,
    this.commercialState,
    this.forumCapability,
    this.resourcesCapability,
    this.reviewsCapability,
    this.bookingCapability,
    this.curriculum = const [],
  });

  final CourseTabsModel? tabs;
  final String? enrollmentState;
  final String? commercialState;
  final CourseCapabilityModel? forumCapability;
  final CourseCapabilityModel? resourcesCapability;
  final CourseCapabilityModel? reviewsCapability;
  final CourseCapabilityModel? bookingCapability;
  @JsonKey(defaultValue: <CourseCurriculumSectionModel>[])
  final List<CourseCurriculumSectionModel> curriculum;

  final String courseId;
  final String title;
  final String? subtitle;
  final String description;
  final String? language;
  final String difficulty;
  final int? estimatedDurationSeconds;
  final String? thumbnailMediaId;
  final Map<String, dynamic>? thumbnail;
  final Map<String, dynamic>? price;
  @JsonKey(defaultValue: <dynamic>[])
  final List<dynamic> availableTabs;
  @JsonKey(defaultValue: <dynamic>[])
  final List<dynamic> availableActions;
  @JsonKey(readValue: _readResponse)
  final Map<String, dynamic> raw;

  factory CourseDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CourseDetailsModelFromJson(json);

  @override
  List<Object?> get props => [
    tabs,
    enrollmentState,
    commercialState,
    forumCapability,
    resourcesCapability,
    reviewsCapability,
    bookingCapability,
    curriculum,
    courseId,
    title,
    subtitle,
    description,
    language,
    difficulty,
    estimatedDurationSeconds,
    thumbnailMediaId,
    thumbnail,
    price,
    availableTabs,
    availableActions,
  ];
}

Object? _readResponse(Map json, String key) => json;
