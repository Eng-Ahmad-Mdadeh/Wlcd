import 'package:equatable/equatable.dart';

class RegisterWithPhoneEntity extends Equatable {
  const RegisterWithPhoneEntity({
    required this.phone,
    required this.challengeId,
    required this.otpCode,
    required this.locale,
  });

  final String phone;
  final String challengeId;
  final String otpCode;
  final String locale;

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'challengeId': challengeId,
    'otpCode': otpCode,
    'locale': locale,
  };

  @override
  List<Object?> get props => [
    phone,
    challengeId,
    otpCode,
    locale,
  ];
}
