// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course_reviews_tab_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CourseReviewsTabModel _$CourseReviewsTabModelFromJson(
  Map<String, dynamic> json,
) => CourseReviewsTabModel(
  accessible: json['accessible'] as bool? ?? false,
  reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
  ratingAverage: (json['ratingAverage'] as num?)?.toDouble(),
  data:
      (json['data'] as List<dynamic>?)
          ?.map((e) => CourseReviewModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      [],
);
