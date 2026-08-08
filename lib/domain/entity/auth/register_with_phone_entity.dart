import 'package:equatable/equatable.dart';

class RegisterWithPhoneEntity extends Equatable {
  const RegisterWithPhoneEntity({
    required this.phone,
    required this.challengeId,
    required this.otpCode,
    required this.locale,
    required this.idempotencyKey,
  });

  final String phone;
  final String challengeId;
  final String otpCode;
  final String locale;
  final String idempotencyKey;

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'challengeId': challengeId,
    'otpCode': otpCode,
    'locale': locale,
  };

  Map<String, dynamic> get headers => {
    'Idempotency-Key': idempotencyKey,
  };

  @override
  List<Object?> get props => [
    phone,
    challengeId,
    otpCode,
    locale,
    idempotencyKey,
  ];
}
