import 'package:equatable/equatable.dart';

class RequestLoginOtpEntity extends Equatable {
  const RequestLoginOtpEntity({required this.phone});
  final String phone;
  Map<String, dynamic> toJson() => {'phone': phone};
  @override
  List<Object?> get props => [phone];
}
