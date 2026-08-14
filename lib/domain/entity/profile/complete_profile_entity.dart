import 'package:equatable/equatable.dart';

class CompleteProfileEntity extends Equatable {
  const CompleteProfileEntity({
    required this.displayName,
    this.email,
    this.phone,
  });

  final String displayName;
  final String? email;
  final String? phone;

  Map<String, dynamic> toJson() => {
    'displayName': displayName,
    if (email != null) 'email': email,
    if (phone != null) 'phone': phone,
  };

  @override
  List<Object?> get props => [displayName, email, phone];
}
