import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'course_review_model.g.dart';

@JsonSerializable(createToJson: false)
class CourseReviewModel extends Equatable {
  const CourseReviewModel({
    required this.reviewId,
    required this.rating,
    this.reviewText,
    this.publishedAt,
  });

  final String reviewId;
  final double rating;
  final String? reviewText;
  final DateTime? publishedAt;

  factory CourseReviewModel.fromJson(Map<String, dynamic> json) =>
      _$CourseReviewModelFromJson(json);

  @override
  List<Object?> get props => [reviewId, rating, reviewText, publishedAt];
}
