import 'package:equatable/equatable.dart';

class RequestPhoneOtpEntity extends Equatable {
  const RequestPhoneOtpEntity({
    required this.phone,
    required this.purpose,
  });

  final String phone;
  final String purpose;

  Map<String, dynamic> toJson() => {
    'phone': phone,
    'purpose': purpose,
  };

  @override
  List<Object?> get props => [phone, purpose];
}
