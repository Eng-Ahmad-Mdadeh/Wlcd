import 'package:equatable/equatable.dart';

class CompleteProfileEntity extends Equatable {
  const CompleteProfileEntity({
    required this.displayName,
    required this.idempotencyKey,
    this.email,
    this.phone,
  });

  final String displayName;
  final String? email;
  final String? phone;
  final String idempotencyKey;

  Map<String, dynamic> toJson() => {
    'displayName': displayName,
    if (email != null) 'email': email,
    if (phone != null) 'phone': phone,
  };

  Map<String, dynamic> get headers => {'Idempotency-Key': idempotencyKey};

  @override
  List<Object?> get props => [displayName, email, phone, idempotencyKey];
}
