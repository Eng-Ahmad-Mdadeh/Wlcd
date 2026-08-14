import 'package:equatable/equatable.dart';

class RegisterWithEmailEntity extends Equatable {
  const RegisterWithEmailEntity({
    required this.displayName,
    required this.email,
    required this.password,
    required this.locale,
    this.correlationId,
  });

  final String displayName;
  final String email;
  final String password;
  final String locale;
  final String? correlationId;

  Map<String, dynamic> toJson() => {
    'displayName': displayName,
    'email': email,
    'password': password,
    'locale': locale,
  };

  Map<String, dynamic> get headers => {
    if (correlationId != null) 'X-Correlation-ID': correlationId,
  };

  @override
  List<Object?> get props => [
    displayName,
    email,
    password,
    locale,
    correlationId,
  ];
}
