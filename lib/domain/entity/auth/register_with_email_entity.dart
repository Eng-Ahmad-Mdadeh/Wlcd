import 'package:equatable/equatable.dart';

class RegisterWithEmailEntity extends Equatable {
  const RegisterWithEmailEntity({
    required this.displayName,
    required this.email,
    required this.password,
    required this.locale,
    required this.idempotencyKey,
    this.correlationId,
  });

  final String displayName;
  final String email;
  final String password;
  final String locale;
  final String idempotencyKey;
  final String? correlationId;

  Map<String, dynamic> toJson() => {
    'displayName': displayName,
    'email': email,
    'password': password,
    'locale': locale,
  };

  Map<String, dynamic> get headers => {
    'Idempotency-Key': idempotencyKey,
    if (correlationId != null) 'X-Correlation-ID': correlationId,
  };

  @override
  List<Object?> get props => [
    displayName,
    email,
    password,
    locale,
    idempotencyKey,
    correlationId,
  ];
}
