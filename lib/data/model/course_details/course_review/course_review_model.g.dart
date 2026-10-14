// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_review_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseReviewModel _$CourseReviewModelFromJson(Map<String, dynamic> json) =>
    CourseReviewModel(
      reviewId: json['reviewId'] as String,
      rating: (json['rating'] as num).toDouble(),
      reviewText: json['reviewText'] as String?,
      publishedAt: json['publishedAt'] == null
          ? null
          : DateTime.parse(json['publishedAt'] as String),
    );
