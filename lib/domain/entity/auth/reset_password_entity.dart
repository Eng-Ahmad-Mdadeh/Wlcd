import 'package:equatable/equatable.dart';

class ResetPasswordEntity extends Equatable {
  const ResetPasswordEntity({required this.token, required this.newPassword, required this.idempotencyKey});
  final String token;
  final String newPassword;
  final String idempotencyKey;
  Map<String, dynamic> toJson() => {'token': token, 'newPassword': newPassword};
  Map<String, dynamic> get headers => {'Idempotency-Key': idempotencyKey};
  @override
  List<Object?> get props => [token, newPassword, idempotencyKey];
}
