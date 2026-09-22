import 'package:equatable/equatable.dart';

class VerifyEmailEntity extends Equatable {
  const VerifyEmailEntity({
    required this.otpCode,
    required this.challengeId,
  });

  final String otpCode;
  final String challengeId;

  Map<String, dynamic> toJson() => {
    'otpCode': otpCode,
    'challengeId': challengeId,
  };

  @override
  List<Object?> get props => [otpCode, challengeId];
}
