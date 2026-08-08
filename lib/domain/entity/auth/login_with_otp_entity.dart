import 'package:equatable/equatable.dart';

class LoginWithOtpEntity extends Equatable {
  const LoginWithOtpEntity({
    required this.challengeId,
    required this.otpCode,
    required this.rememberMe,
    required this.idempotencyKey,
  });

  final String challengeId;
  final String otpCode;
  final bool rememberMe;
  final String idempotencyKey;

  Map<String, dynamic> toJson() => {
    'challengeId': challengeId,
    'otpCode': otpCode,
    'rememberMe': rememberMe,
  };

  Map<String, dynamic> get headers => {'Idempotency-Key': idempotencyKey};

  @override
  List<Object?> get props => [
    challengeId,
    otpCode,
    rememberMe,
    idempotencyKey,
  ];
}
