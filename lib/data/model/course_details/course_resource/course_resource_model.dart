import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_resource_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseResourceModel extends Equatable {
  const CourseResourceModel({
    required this.resourceId,
    required this.title,
    required this.resourceType,
    this.fileSizeBytes,
    this.displayOrder = 0,
  });

  final String resourceId;
  final String title;
  final String resourceType;
  final int? fileSizeBytes;
  @JsonKey(defaultValue: 0)
  final int displayOrder;

  factory CourseResourceModel.fromJson(Map<String, dynamic> json) =>
      _$CourseResourceModelFromJson(json);

  @override
  List<Object?> get props => [
    resourceId,
    title,
    resourceType,
    fileSizeBytes,
    displayOrder,
  ];
}
