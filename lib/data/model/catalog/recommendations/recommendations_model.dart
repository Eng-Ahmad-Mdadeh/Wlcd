import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/recommendation/recommendation_model.dart';

part 'recommendations_model.g.dart';

@JsonSerializable(createToJson: false)
class RecommendationsModel extends Equatable {
  const RecommendationsModel({required this.data});

  final List<RecommendationModel> data;

  factory RecommendationsModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationsModelFromJson(json);

  @override
  List<Object?> get props => [data];
}
