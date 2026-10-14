import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/course_price/course_price_model.dart';
import 'package:wlcd/data/model/catalog/course_thumbnail/course_thumbnail_model.dart';
import 'package:wlcd/data/model/course_details/course_instructor/course_instructor_model.dart';

part 'course_overview_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseOverviewModel extends Equatable {
  const CourseOverviewModel({
    required this.description,
    this.subtitle,
    this.language,
    this.difficulty,
    this.estimatedDurationSeconds,
    this.thumbnail,
    this.instructor,
    this.price,
  });

  final String description;
  final String? subtitle;
  final String? language;
  final String? difficulty;
  final int? estimatedDurationSeconds;
  final CourseThumbnailModel? thumbnail;
  final CourseInstructorModel? instructor;
  final CoursePriceModel? price;

  factory CourseOverviewModel.fromJson(Map<String, dynamic> json) =>
      _$CourseOverviewModelFromJson(json);

  @override
  List<Object?> get props => [
    description,
    subtitle,
    language,
    difficulty,
    estimatedDurationSeconds,
    thumbnail,
    instructor,
    price,
  ];
}
