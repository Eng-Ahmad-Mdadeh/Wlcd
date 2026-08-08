import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'phone_otp_challenge_model.g.dart';

@JsonSerializable(createToJson: false)
class PhoneOtpChallengeModel extends Equatable {
  const PhoneOtpChallengeModel({
    required this.challengeId,
    required this.expiresAt,
    required this.cooldownSeconds,
  });

  final String? challengeId;
  final DateTime? expiresAt;
  final int? cooldownSeconds;

  factory PhoneOtpChallengeModel.fromJson(Map<String, dynamic> json) =>
      _$PhoneOtpChallengeModelFromJson(json);

  @override
  List<Object?> get props => [challengeId, expiresAt, cooldownSeconds];
}
