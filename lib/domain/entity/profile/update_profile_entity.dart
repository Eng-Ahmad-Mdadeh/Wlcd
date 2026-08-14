import 'package:equatable/equatable.dart';

class UpdateProfileEntity extends Equatable {
  const UpdateProfileEntity({
    required this.idempotencyKey,
    required this.ifMatch,
    this.displayName,
    this.email,
    this.phone,
    this.locale,
  });

  final String? displayName;
  final String? email;
  final String? phone;
  final String? locale;
  final String idempotencyKey;
  final String ifMatch;

  Map<String, dynamic> toJson() => {
    if (displayName != null) 'displayName': displayName,
    if (email != null) 'email': email,
    if (phone != null) 'phone': phone,
    if (locale != null) 'locale': locale,
  };

  Map<String, dynamic> get headers => {
    'Idempotency-Key': idempotencyKey,
    'If-Match': ifMatch,
  };

  @override
  List<Object?> get props => [
    displayName,
    email,
    phone,
    locale,
    idempotencyKey,
    ifMatch,
  ];
}
