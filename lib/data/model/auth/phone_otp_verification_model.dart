import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_otp_verification_model.g.dart';

@JsonSerializable(createToJson: false)
class PhoneOtpVerificationModel extends Equatable {
  const PhoneOtpVerificationModel({required this.verified, required this.challengeId});

  final bool? verified;
  final String? challengeId;

  factory PhoneOtpVerificationModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneOtpVerificationModelFromJson(json);

  @override
  List<Object?> get props => [verified, challengeId];
}
