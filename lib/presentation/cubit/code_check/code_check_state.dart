part of 'code_check_cubit.dart';

sealed class CodeCheckState extends Equatable {
  final DateTime endDate;
  final String phone;
  final String dialCode;
  final String type;
  final bool rememberMe;

  const CodeCheckState(this.endDate, this.phone, this.rememberMe, this.type, this.dialCode);
}

final class CodeCheckEndDateInitial extends CodeCheckState {
  const CodeCheckEndDateInitial(super.endDate, super.phone, super.rememberMe, super.type, super.dialCode);

  @override
  List<Object> get props => [endDate, phone, rememberMe,type,dialCode];
}

final class CodeCheckEndDateChanged extends CodeCheckState {
  const CodeCheckEndDateChanged(super.endDate, super.phone, super.rememberMe, super.type, super.dialCode);

  @override
  List<Object> get props => [endDate, phone, rememberMe,type,dialCode];
}
