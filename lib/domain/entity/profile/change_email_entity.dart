import 'package:equatable/equatable.dart';

class ChangeEmailEntity extends Equatable {
  const ChangeEmailEntity({required this.email});

  final String email;

  ChangeEmailEntity copyWith({String? email}) => ChangeEmailEntity(email: email ?? this.email);

  Map<String, dynamic> toJson() => {'newEmail': email};

  @override
  List<Object?> get props => [email];
}
