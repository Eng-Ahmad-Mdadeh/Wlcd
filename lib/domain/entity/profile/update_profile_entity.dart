import 'package:equatable/equatable.dart';

class UpdateProfileEntity extends Equatable {
  const UpdateProfileEntity({
    this.displayName,
    this.email,
    this.phone,
    this.locale,
  });

  final String? displayName;
  final String? email;
  final String? phone;
  final String? locale;

  UpdateProfileEntity copyWith({
    String? displayName,
    String? email,
    String? phone,
    String? locale,
  }) {
    return UpdateProfileEntity(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      locale: locale ?? this.locale,
    );
  }

  Map<String, dynamic> toJson() => {
    if (displayName != null) 'displayName': displayName,
    if (email != null) 'email': email,
    if (phone != null) 'phone': phone,
    if (locale != null) 'locale': locale,
  };

  @override
  List<Object?> get props => [
    displayName,
    email,
    phone,
    locale,
  ];
}
