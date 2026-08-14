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

  UpdateProfileEntity copyWith({
    String? displayName,
    String? email,
    String? phone,
    String? locale,
    String? idempotencyKey,
    String? ifMatch,
  }) {
    return UpdateProfileEntity(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      locale: locale ?? this.locale,
      idempotencyKey: idempotencyKey ?? this.idempotencyKey,
      ifMatch: ifMatch ?? this.ifMatch,
    );
  }

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
