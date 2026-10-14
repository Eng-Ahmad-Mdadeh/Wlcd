// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'enrollment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EnrollmentModel _$EnrollmentModelFromJson(Map<String, dynamic> json) =>
    EnrollmentModel(
      enrollmentId: json['enrollmentId'] as String,
      accountId: json['accountId'] as String,
      courseId: json['courseId'] as String,
      status: json['status'] as String,
      grantSource: json['grantSource'] as String,
      enrolledPublishedRevisionId:
          json['enrolledPublishedRevisionId'] as String,
      pinSource: json['pinSource'] as String,
      activatedAt: DateTime.parse(json['activatedAt'] as String),
    );
