import 'package:equatable/equatable.dart';

class LoginWithPasswordEntity extends Equatable {
  const LoginWithPasswordEntity({
    required this.email,
    required this.password,
    required this.rememberMe,
  });

  final String email;
  final String password;
  final bool rememberMe;

  Map<String, dynamic> toJson() => {
    'email': email,
    'password': password,
    'rememberMe': rememberMe,
  };

  @override
  List<Object?> get props => [email, password, rememberMe];
}
