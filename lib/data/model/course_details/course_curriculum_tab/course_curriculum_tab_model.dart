import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/course_details/course_curriculum_section/course_curriculum_section_model.dart';

part 'course_curriculum_tab_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseCurriculumTabModel extends Equatable {
  const CourseCurriculumTabModel({this.data = const []});

  @JsonKey(defaultValue: <CourseCurriculumSectionModel>[])
  final List<CourseCurriculumSectionModel> data;

  factory CourseCurriculumTabModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCurriculumTabModelFromJson(json);

  @override
  List<Object?> get props => [data];
}
