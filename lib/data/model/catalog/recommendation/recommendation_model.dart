import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/catalog/course/course_model.dart';

part 'recommendation_model.g.dart';

@JsonSerializable(createToJson: false)
class RecommendationModel extends Equatable {
  const RecommendationModel({
    required this.courseId,
    required this.reasonCode,
    required this.card,
  });

  final String courseId;
  final String reasonCode;
  final CourseModel card;

  factory RecommendationModel.fromJson(Map<String, dynamic> json) =>
      _$RecommendationModelFromJson(json);

  @override
  List<Object?> get props => [courseId, reasonCode, card];
}
