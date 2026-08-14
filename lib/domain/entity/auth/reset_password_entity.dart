import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  const ResetPasswordEntity({required this.token, required this.newPassword});
  final String token;
  final String newPassword;
  Map<String, dynamic> toJson() => {'token': token, 'newPassword': newPassword};
  @override
  List<Object?> get props => [token, newPassword];
}
