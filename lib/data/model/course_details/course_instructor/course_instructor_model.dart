import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/course_thumbnail/course_thumbnail_model.dart';

part 'course_instructor_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseInstructorModel extends Equatable {
  const CourseInstructorModel({
    required this.instructorId,
    required this.displayName,
    this.headline,
    this.avatarMediaId,
    this.avatar,
  });

  final String instructorId;
  final String displayName;
  final String? headline;
  final String? avatarMediaId;
  final CourseThumbnailModel? avatar;

  factory CourseInstructorModel.fromJson(Map<String, dynamic> json) =>
      _$CourseInstructorModelFromJson(json);

  @override
  List<Object?> get props => [
    instructorId,
    displayName,
    headline,
    avatarMediaId,
    avatar,
  ];
}
