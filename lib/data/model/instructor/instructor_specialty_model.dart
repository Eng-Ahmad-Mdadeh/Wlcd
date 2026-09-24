import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'instructor_specialty_model.g.dart';

@JsonSerializable(createToJson: false)
class InstructorSpecialtyModel extends Equatable {
  const InstructorSpecialtyModel({this.categoryId, this.title});

  final String? categoryId;
  final String? title;

  factory InstructorSpecialtyModel.fromJson(Map<String, dynamic> json) =>
      _$InstructorSpecialtyModelFromJson(json);

  @override
  List<Object?> get props => [categoryId, title];
}
