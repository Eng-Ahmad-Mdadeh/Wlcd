import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/course_details/course_review/course_review_model.dart';

part 'course_reviews_tab_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseReviewsTabModel extends Equatable {
  const CourseReviewsTabModel({
    this.accessible = false,
    this.reviewCount = 0,
    this.ratingAverage,
    this.data = const [],
  });

  @JsonKey(defaultValue: false)
  final bool accessible;
  @JsonKey(defaultValue: 0)
  final int reviewCount;
  final double? ratingAverage;
  @JsonKey(defaultValue: <CourseReviewModel>[])
  final List<CourseReviewModel> data;

  factory CourseReviewsTabModel.fromJson(Map<String, dynamic> json) =>
      _$CourseReviewsTabModelFromJson(json);

  @override
  List<Object?> get props => [accessible, reviewCount, ratingAverage, data];
}
