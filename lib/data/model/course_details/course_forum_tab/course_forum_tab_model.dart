import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/course_details/course_forum_thread/course_forum_thread_model.dart';

part 'course_forum_tab_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseForumTabModel extends Equatable {
  const CourseForumTabModel({
    this.accessible = false,
    this.requiresAuthentication = false,
    this.requiresEnrollment = false,
    this.data = const [],
  });

  @JsonKey(defaultValue: false)
  final bool accessible;
  @JsonKey(defaultValue: false)
  final bool requiresAuthentication;
  @JsonKey(defaultValue: false)
  final bool requiresEnrollment;
  @JsonKey(defaultValue: <CourseForumThreadModel>[])
  final List<CourseForumThreadModel> data;

  factory CourseForumTabModel.fromJson(Map<String, dynamic> json) =>
      _$CourseForumTabModelFromJson(json);

  @override
  List<Object?> get props => [
    accessible,
    requiresAuthentication,
    requiresEnrollment,
    data,
  ];
}
