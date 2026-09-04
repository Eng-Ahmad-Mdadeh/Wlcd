// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationModel _$RecommendationModelFromJson(Map<String, dynamic> json) =>
    RecommendationModel(
      courseId: json['courseId'] as String,
      reasonCode: json['reasonCode'] as String,
      card: CourseModel.fromJson(json['card'] as Map<String, dynamic>),
    );
