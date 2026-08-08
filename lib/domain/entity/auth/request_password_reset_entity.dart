import 'package:equatable/equatable.dart';

class RequestPasswordResetEntity extends Equatable {
  const RequestPasswordResetEntity({required this.email});
  final String email;
  Map<String, dynamic> toJson() => {'email': email};
  @override
  List<Object?> get props => [email];
}
