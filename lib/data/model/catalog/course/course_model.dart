import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/course_price/course_price_model.dart';
import 'package:wlcd/data/model/catalog/course_thumbnail/course_thumbnail_model.dart';

part 'course_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseModel extends Equatable {
  const CourseModel({
     this.courseId,
     this.title,
     this.subtitle,
     this.thumbnailMediaId,
     this.primaryCategoryLabel,
     this.difficulty,
     this.estimatedDurationSeconds,
     this.instructorDisplayName,
     this.publishedAt,
     this.thumbnail,
     this.price,
     this.isFree,
     this.ratingAverage,
     this.ratingCount,
     this.instructorId,
     this.commercialAvailability,
  });

  final String? courseId;
  final String? title;
  final String? subtitle;
  final String? thumbnailMediaId;
  final String? primaryCategoryLabel;
  final String? difficulty;
  final int? estimatedDurationSeconds;
  final String? instructorDisplayName;
  final DateTime? publishedAt;
  final CourseThumbnailModel? thumbnail;
  final CoursePriceModel? price;
  final bool? isFree;
  final double? ratingAverage;
  final int? ratingCount;
  final String? instructorId;
  final String? commercialAvailability;


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
