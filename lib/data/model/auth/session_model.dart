import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';

part 'session_model.g.dart';

@JsonSerializable(createToJson: false)
class SessionModel extends Equatable {
  const SessionModel({
    required this.sessionId,
    required this.accountId,
    required this.expiresAt,
    required this.authMethod,
    required this.account,
    required this.profileComplete,
    required this.onboardingComplete,
    required this.effectivePermissions,
  });

  final String? sessionId;
  final String? accountId;
  final DateTime? expiresAt;
  final String? authMethod;
  final AuthAccountModel? account;
  final bool? profileComplete;
  final bool? onboardingComplete;
  final List<String> effectivePermissions;

  factory SessionModel.fromJson(Map<String, dynamic> json) =>
      _$SessionModelFromJson(json);

  @override
  List<Object?> get props => [
    sessionId,
    accountId,
    expiresAt,
    authMethod,
    account,
    profileComplete,
    onboardingComplete,
    effectivePermissions,
  ];
}
