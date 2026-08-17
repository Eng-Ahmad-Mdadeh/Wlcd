import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/Catalog/course/course_price_model.dart';
import 'package:wlcd/data/model/Catalog/course/course_thumbnail_model.dart';

part 'course_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseModel extends Equatable {
  const CourseModel({
    required this.courseId,
    required this.title,
    required this.subtitle,
    required this.thumbnailMediaId,
    required this.primaryCategoryLabel,
    required this.difficulty,
    required this.estimatedDurationSeconds,
    required this.instructorDisplayName,
    required this.publishedAt,
    required this.thumbnail,
    required this.price,
    required this.isFree,
    required this.ratingAverage,
    required this.ratingCount,
    required this.instructorId,
    required this.commercialAvailability,
  });

  final String courseId;
  final String title;
  final String subtitle;
  final String thumbnailMediaId;
  final String primaryCategoryLabel;
  final String difficulty;
  final int estimatedDurationSeconds;
  final String instructorDisplayName;
  final DateTime publishedAt;
  final CourseThumbnailModel thumbnail;
  final CoursePriceModel price;
  final bool isFree;
  final double? ratingAverage;
  final int ratingCount;
  final String instructorId;
  final String commercialAvailability;

  factory CourseModel.fromJson(Map<String, dynamic> json) =>
      _$CourseModelFromJson(json);

  @override
  List<Object?> get props => [
    courseId,
    title,
    subtitle,
    thumbnailMediaId,
    primaryCategoryLabel,
    difficulty,
    estimatedDurationSeconds,
    instructorDisplayName,
    publishedAt,
    thumbnail,
    price,
    isFree,
    ratingAverage,
    ratingCount,
    instructorId,
    commercialAvailability,
  ];
}
