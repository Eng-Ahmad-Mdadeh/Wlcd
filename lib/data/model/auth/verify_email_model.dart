import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'verify_email_model.g.dart';

@JsonSerializable(createToJson: false)
class VerifyEmailModel extends Equatable {
  const VerifyEmailModel({
    required this.verified,
    required this.accountId,
  });

  final bool? verified;
  final String? accountId;

  factory VerifyEmailModel.fromJson(Map<String, dynamic> json) =>
      _$VerifyEmailModelFromJson(json);

  @override
  List<Object?> get props => [verified, accountId];
}
