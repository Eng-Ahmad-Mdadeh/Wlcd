import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/course_details/course_curriculum_lesson/course_curriculum_lesson_model.dart';

part 'course_curriculum_section_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseCurriculumSectionModel extends Equatable {
  const CourseCurriculumSectionModel({
    required this.sectionId,
    required this.title,
    this.displayOrder = 0,
    this.lessons = const [],
  });

  final String sectionId;
  final String title;
  @JsonKey(defaultValue: 0)
  final int displayOrder;
  @JsonKey(defaultValue: <CourseCurriculumLessonModel>[])
  final List<CourseCurriculumLessonModel> lessons;

  factory CourseCurriculumSectionModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCurriculumSectionModelFromJson(json);

  @override
  List<Object?> get props => [sectionId, title, displayOrder, lessons];
}
