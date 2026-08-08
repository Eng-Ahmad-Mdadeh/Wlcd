import 'package:equatable/equatable.dart';

class VerifyPhoneOtpEntity extends Equatable {
  const VerifyPhoneOtpEntity({required this.challengeId, required this.otpCode});
  final String challengeId;
  final String otpCode;
  Map<String, dynamic> toJson() => {'challengeId': challengeId, 'otpCode': otpCode};
  @override
  List<Object?> get props => [challengeId, otpCode];
}
