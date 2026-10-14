import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'curriculum_model.g.dart';

@JsonSerializable(createToJson: false)
class CurriculumModel extends Equatable {
  const CurriculumModel({
    required this.courseId,
    required this.enrollmentId,
    required this.enrolledPublishedRevisionId,
    required this.learningStatus,
    required this.completionPercentage,
    required this.sections,
    this.courseTitle,
    this.lastAccessedLessonId,
  });

  final String courseId;
  final String enrollmentId;
  final String enrolledPublishedRevisionId;
  final String learningStatus;
  final String? courseTitle;
  final String? lastAccessedLessonId;
  final int completionPercentage;
  @JsonKey(defaultValue: <dynamic>[])
  final List<dynamic> sections;

  factory CurriculumModel.fromJson(Map<String, dynamic> json) =>
      _$CurriculumModelFromJson(json);

  @override
  List<Object?> get props => [
    courseId,
    enrollmentId,
    enrolledPublishedRevisionId,
    courseTitle,
    learningStatus,
    completionPercentage,
    lastAccessedLessonId,
    sections,
  ];
}
