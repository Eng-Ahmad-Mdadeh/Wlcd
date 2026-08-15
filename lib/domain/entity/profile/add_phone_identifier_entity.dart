import 'package:equatable/equatable.dart';

class AddPhoneIdentifierEntity extends Equatable {
  const AddPhoneIdentifierEntity({
    required this.phone,
    required this.challengeId,
    required this.otpCode,
  });

  final String phone;
  final String challengeId;
  final String otpCode;

  AddPhoneIdentifierEntity copyWith({
    String? phone,
    String? challengeId,
    String? otpCode,
  }) => AddPhoneIdentifierEntity(
    phone: phone ?? this.phone,
    challengeId: challengeId ?? this.challengeId,
    otpCode: otpCode ?? this.otpCode,
  );

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'challengeId': challengeId,
    'otpCode': otpCode,
  };

  @override
  List<Object?> get props => [phone, challengeId, otpCode];
}
