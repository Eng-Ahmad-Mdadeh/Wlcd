import 'package:equatable/equatable.dart';

class AddPhoneIdentifierEntity extends Equatable {
  const AddPhoneIdentifierEntity({required this.phone});

  final String phone;

  AddPhoneIdentifierEntity copyWith({String? phone}) =>
      AddPhoneIdentifierEntity(phone: phone ?? this.phone);

  Map<String, dynamic> toJson() => {'phone': phone};

  @override
  List<Object?> get props => [phone];
}
