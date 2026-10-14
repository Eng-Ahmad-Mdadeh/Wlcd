import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_curriculum_lesson_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseCurriculumLessonModel extends Equatable {
  const CourseCurriculumLessonModel({
    required this.lessonId,
    required this.title,
    required this.lessonType,
    this.displayOrder = 0,
    this.durationEstimateSeconds,
    this.isPreviewEligible = false,
  });

  final String lessonId;
  final String title;
  final String lessonType;
  @JsonKey(defaultValue: 0)
  final int displayOrder;
  final int? durationEstimateSeconds;
  @JsonKey(defaultValue: false)
  final bool isPreviewEligible;

  factory CourseCurriculumLessonModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCurriculumLessonModelFromJson(json);

  @override
  List<Object?> get props => [
    lessonId,
    title,
    lessonType,
    displayOrder,
    durationEstimateSeconds,
    isPreviewEligible,
  ];
}
