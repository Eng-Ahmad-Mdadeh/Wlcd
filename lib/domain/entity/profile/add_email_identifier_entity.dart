import 'package:equatable/equatable.dart';

class AddEmailIdentifierEntity extends Equatable {
  const AddEmailIdentifierEntity({required this.email});

  final String email;

  AddEmailIdentifierEntity copyWith({String? email}) =>
      AddEmailIdentifierEntity(email: email ?? this.email);

  Map<String, dynamic> toJson() => {'email': email};

  @override
  List<Object?> get props => [email];
}
