import 'package:equatable/equatable.dart';

class ChangePhoneEntity extends Equatable {
  const ChangePhoneEntity({
    required this.newPhone,
    required this.challengeId,
    required this.otpCode,
  });

  final String newPhone;
  final String challengeId;
  final String otpCode;

  ChangePhoneEntity copyWith({
    String? newPhone,
    String? challengeId,
    String? otpCode,
  }) => ChangePhoneEntity(
    newPhone: newPhone ?? this.newPhone,
    challengeId: challengeId ?? this.challengeId,
    otpCode: otpCode ?? this.otpCode,
  );

  Map<String, dynamic> toJson() => {
    'newPhone': newPhone,
    'challengeId': challengeId,
    'otpCode': otpCode,
  };

  @override
  List<Object?> get props => [newPhone, challengeId, otpCode];
}
