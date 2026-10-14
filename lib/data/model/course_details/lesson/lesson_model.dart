import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'lesson_model.g.dart';

@JsonSerializable(createToJson: false)
class LessonModel extends Equatable {
  const LessonModel({
    required this.courseId,
    required this.lessonId,
    required this.enrolledPublishedRevisionId,
    required this.title,
    required this.lessonType,
    required this.completionExpectation,
    this.description,
    this.contentDurationSeconds,
    this.mediaReferenceId,
  });

  final String courseId;
  final String lessonId;
  final String enrolledPublishedRevisionId;
  final String title;
  final String lessonType;
  final String completionExpectation;
  final String? description;
  final String? mediaReferenceId;
  final int? contentDurationSeconds;

  factory LessonModel.fromJson(Map<String, dynamic> json) =>
      _$LessonModelFromJson(json);

  @override
  List<Object?> get props => [
    courseId,
    lessonId,
    enrolledPublishedRevisionId,
    title,
    description,
    lessonType,
    contentDurationSeconds,
    completionExpectation,
    mediaReferenceId,
  ];
}
