import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'navigation_target_model.g.dart';

@JsonSerializable(createToJson: false)
class NavigationTargetModel extends Equatable {
  const NavigationTargetModel({required this.targetType, this.targetId, this.action});

  final String targetType;
  final String? targetId;
  final String? action;

  factory NavigationTargetModel.fromJson(Map<String, dynamic> json) =>
      _$NavigationTargetModelFromJson(json);

  @override
  List<Object?> get props => [targetType, targetId, action];
}
