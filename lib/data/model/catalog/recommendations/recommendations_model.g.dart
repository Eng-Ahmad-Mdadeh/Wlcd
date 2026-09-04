// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'recommendations_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendationsModel _$RecommendationsModelFromJson(
  Map<String, dynamic> json,
) => RecommendationsModel(
  data: (json['data'] as List<dynamic>)
      .map((e) => RecommendationModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);
