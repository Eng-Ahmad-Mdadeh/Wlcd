import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'operation_success_model.g.dart';

@JsonSerializable(createToJson: false)
class OperationSuccessModel extends Equatable {
  const OperationSuccessModel({required this.success});

  final bool? success;

  factory OperationSuccessModel.fromJson(Map<String, dynamic> json) =>
      _$OperationSuccessModelFromJson(json);

  @override
  List<Object?> get props => [success];
}
