import 'package:equatable/equatable.dart';

class LoginWithOtpEntity extends Equatable {
  const LoginWithOtpEntity({
    required this.challengeId,
    required this.otpCode,
    required this.rememberMe,
  });

  final String challengeId;
  final String otpCode;
  final bool rememberMe;

  Map<String, dynamic> toJson() => {
    'challengeId': challengeId,
    'otpCode': otpCode,
    'rememberMe': rememberMe,
  };

  @override
  List<Object?> get props => [
    challengeId,
    otpCode,
    rememberMe,
  ];
}
