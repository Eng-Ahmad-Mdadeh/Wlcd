import 'package:equatable/equatable.dart';

class LoginWithPasswordEntity extends Equatable {
  const LoginWithPasswordEntity({
    required this.email,
    required this.password,
    required this.rememberMe,
    required this.idempotencyKey,
  });

  final String email;
  final String password;
  final bool rememberMe;
  final String idempotencyKey;

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'rememberMe': rememberMe,
  };

  Map<String, dynamic> get headers => {'Idempotency-Key': idempotencyKey};

  @override
  List<Object?> get props => [email, password, rememberMe, idempotencyKey];
}
