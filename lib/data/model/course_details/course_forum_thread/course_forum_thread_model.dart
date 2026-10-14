import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_forum_thread_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseForumThreadModel extends Equatable {
  const CourseForumThreadModel({
    required this.forumThreadId,
    required this.courseId,
    required this.title,
    this.lockState,
    this.lifecycleState,
    this.createdAt,
  });

  final String forumThreadId;
  final String courseId;
  final String title;
  final String? lockState;
  final String? lifecycleState;
  final DateTime? createdAt;

  factory CourseForumThreadModel.fromJson(Map<String, dynamic> json) =>
      _$CourseForumThreadModelFromJson(json);

  @override
  List<Object?> get props => [
    forumThreadId,
    courseId,
    title,
    lockState,
    lifecycleState,
    createdAt,
  ];
}
