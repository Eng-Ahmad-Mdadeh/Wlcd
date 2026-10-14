import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/course_details/course_resource/course_resource_model.dart';

part 'course_resources_tab_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseResourcesTabModel extends Equatable {
  const CourseResourcesTabModel({
    this.accessible = false,
    this.requiresAuthentication = false,
    this.requiresEnrollment = false,
    this.resourceCount = 0,
    this.data = const [],
  });

  @JsonKey(defaultValue: false)
  final bool accessible;
  @JsonKey(defaultValue: false)
  final bool requiresAuthentication;
  @JsonKey(defaultValue: false)
  final bool requiresEnrollment;
  @JsonKey(defaultValue: 0)
  final int resourceCount;
  @JsonKey(defaultValue: <CourseResourceModel>[])
  final List<CourseResourceModel> data;

  factory CourseResourcesTabModel.fromJson(Map<String, dynamic> json) =>
      _$CourseResourcesTabModelFromJson(json);

  @override
  List<Object?> get props => [
    accessible,
    requiresAuthentication,
    requiresEnrollment,
    resourceCount,
    data,
  ];
}
