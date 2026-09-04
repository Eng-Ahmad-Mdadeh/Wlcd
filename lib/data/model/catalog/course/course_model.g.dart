// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseModel _$CourseModelFromJson(Map<String, dynamic> json) => CourseModel(
  courseId: json['courseId'] as String?,
  title: json['title'] as String?,
  subtitle: json['subtitle'] as String?,
  thumbnailMediaId: json['thumbnailMediaId'] as String?,
  primaryCategoryLabel: json['primaryCategoryLabel'] as String?,
  difficulty: json['difficulty'] as String?,
  estimatedDurationSeconds: json['estimatedDurationSeconds'] != null
      ? null
      : (json['estimatedDurationSeconds'] as num).toInt(),
  instructorDisplayName: json['instructorDisplayName'] as String?,
  publishedAt: json['publishedAt'] != null ? null : DateTime.parse(json['publishedAt'] as String),
  thumbnail: CourseThumbnailModel.fromJson(json['thumbnail'] as Map<String, dynamic>),
  price: CoursePriceModel.fromJson(json['price'] as Map<String, dynamic>),
  isFree: json['isFree'] as bool,
  ratingAverage: (json['ratingAverage'] as num?)?.toDouble(),
  ratingCount: (json['ratingCount'] as num).toInt(),
  instructorId: json['instructorId'] as String,
  commercialAvailability: json['commercialAvailability'] as String,
);
