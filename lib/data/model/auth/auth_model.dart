import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'auth_model.g.dart';

@JsonSerializable(createToJson: false)
class AuthModel extends Equatable {
  const AuthModel({
    required this.accessToken,
    required this.tokenType,
    required this.expiresAt,
    required this.sessionId,
    required this.account,
    required this.effectivePermissions,
  });

  final String? accessToken;
  final String? tokenType;
  final DateTime? expiresAt;
  final String? sessionId;
  final AuthAccountModel? account;
  final List<String> effectivePermissions;

  factory AuthModel.fromJson(Map<String, dynamic> json) =>
      _$AuthModelFromJson(json);

  @override
  List<Object?> get props => [
    accessToken,
    tokenType,
    expiresAt,
    sessionId,
    account,
    effectivePermissions,
  ];
}

@JsonSerializable(createToJson: false)
class AuthAccountModel extends Equatable {
  const AuthAccountModel({
    required this.accountId,
    required this.status,
    required this.profileComplete,
    this.displayName,
    this.email,
    this.phone,
    this.onboardingComplete,
  });

  final String? accountId;
  final String? status;
  final bool? profileComplete;
  final String? displayName;
  final String? email;
  final String? phone;
  final bool? onboardingComplete;

  factory AuthAccountModel.fromJson(Map<String, dynamic> json) =>
      _$AuthAccountModelFromJson(json);

  @override
  List<Object?> get props => [
    accountId,
    status,
    profileComplete,
    displayName,
    email,
    phone,
    onboardingComplete,
  ];
}
