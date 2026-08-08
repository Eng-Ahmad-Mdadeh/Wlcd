import 'package:equatable/equatable.dart';

class VerifyEmailEntity extends Equatable {
  const VerifyEmailEntity({
    required this.token,
    required this.challengeId,
  });

  final String token;
  final String challengeId;

  Map<String, dynamic> toJson() => {
    'token': token,
    'challengeId': challengeId,
  };

  @override
  List<Object?> get props => [token, challengeId];
}
