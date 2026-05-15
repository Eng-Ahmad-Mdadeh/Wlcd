import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'delete_account_model.g.dart';

@JsonSerializable(createToJson: false)
class DeleteAccountModel extends Equatable {
  const DeleteAccountModel({
    this.id,
  });

  final String? id;

  factory DeleteAccountModel.fromJson(Map<String, dynamic> json) =>
      _$DeleteAccountModelFromJson(json);

  @override
  List<Object?> get props => [id];
}
