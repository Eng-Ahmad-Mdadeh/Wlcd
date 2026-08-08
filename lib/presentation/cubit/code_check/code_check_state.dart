part of 'code_check_cubit.dart';

sealed class CodeCheckState extends Equatable {
  final DateTime endDate;
  final String phone;
  final String dialCode;
  final String type;
  final bool rememberMe;
  final String challengeId;

  const CodeCheckState(this.endDate, this.phone, this.rememberMe, this.type, this.dialCode, this.challengeId);
}

final class CodeCheckEndDateInitial extends CodeCheckState {
  const CodeCheckEndDateInitial(super.endDate, super.phone, super.rememberMe, super.type, super.dialCode, super.challengeId);

  @override
  List<Object> get props => [endDate, phone, rememberMe, type, dialCode, challengeId];
}

final class CodeCheckEndDateChanged extends CodeCheckState {
  const CodeCheckEndDateChanged(super.endDate, super.phone, super.rememberMe, super.type, super.dialCode, super.challengeId);

  @override
  List<Object> get props => [endDate, phone, rememberMe, type, dialCode, challengeId];
}
