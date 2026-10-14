import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'enrollment_model.g.dart';

@JsonSerializable(createToJson: false)
class EnrollmentModel extends Equatable {
  const EnrollmentModel({
    required this.enrollmentId,
    required this.accountId,
    required this.courseId,
    required this.status,
    required this.grantSource,
    required this.enrolledPublishedRevisionId,
    required this.pinSource,
    required this.activatedAt,
  });

  final String enrollmentId;
  final String accountId;
  final String courseId;
  final String status;
  final String grantSource;
  final String enrolledPublishedRevisionId;
  final String pinSource;
  final DateTime activatedAt;

  factory EnrollmentModel.fromJson(Map<String, dynamic> json) =>
      _$EnrollmentModelFromJson(json);

  @override
  List<Object?> get props => [
    enrollmentId,
    accountId,
    courseId,
    status,
    grantSource,
    enrolledPublishedRevisionId,
    pinSource,
    activatedAt,
  ];
}
