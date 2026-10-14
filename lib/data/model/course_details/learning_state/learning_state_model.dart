import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'learning_state_model.g.dart';

@JsonSerializable(createToJson: false)
class LearningStateModel extends Equatable {
  const LearningStateModel({
    required this.enrollmentId,
    required this.courseId,
    required this.enrolledPublishedRevisionId,
    required this.learningStatus,
    required this.completedLessonCount,
    required this.totalRequiredLessonCount,
    required this.completionPercentage,
    this.lastAccessedLessonId,
    this.completedAt,
  });

  final String enrollmentId;
  final String courseId;
  final String enrolledPublishedRevisionId;
  final String learningStatus;
  final int completedLessonCount;
  final int totalRequiredLessonCount;
  final int completionPercentage;
  final String? lastAccessedLessonId;
  final DateTime? completedAt;

  factory LearningStateModel.fromJson(Map<String, dynamic> json) =>
      _$LearningStateModelFromJson(json);

  @override
  List<Object?> get props => [
    enrollmentId,
    courseId,
    enrolledPublishedRevisionId,
    learningStatus,
    completedLessonCount,
    totalRequiredLessonCount,
    completionPercentage,
    lastAccessedLessonId,
    completedAt,
  ];
}
