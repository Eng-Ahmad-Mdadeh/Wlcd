import 'package:equatable/equatable.dart';

class ChangePhoneEntity extends Equatable {
  const ChangePhoneEntity({required this.phone});

  final String phone;

  ChangePhoneEntity copyWith({String? phone}) =>
      ChangePhoneEntity(phone: phone ?? this.phone);

  Map<String, dynamic> toJson() => {'phone': phone};

  @override
  List<Object?> get props => [phone];
}
