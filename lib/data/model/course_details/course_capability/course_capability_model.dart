import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_capability_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseCapabilityModel extends Equatable {
  const CourseCapabilityModel({
    this.available = false,
    this.requiresAuthentication = false,
    this.requiresEnrollment = false,
    this.resourceCount,
    this.reviewCount,
    this.instructorId,
  });

  @JsonKey(defaultValue: false)
  final bool available;
  @JsonKey(defaultValue: false)
  final bool requiresAuthentication;
  @JsonKey(defaultValue: false)
  final bool requiresEnrollment;
  final int? resourceCount;
  final int? reviewCount;
  final String? instructorId;

  factory CourseCapabilityModel.fromJson(Map<String, dynamic> json) =>
      _$CourseCapabilityModelFromJson(json);

  @override
  List<Object?> get props => [
    available,
    requiresAuthentication,
    requiresEnrollment,
    resourceCount,
    reviewCount,
    instructorId,
  ];
}
