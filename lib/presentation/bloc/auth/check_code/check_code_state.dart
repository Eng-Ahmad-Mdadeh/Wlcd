part of "check_code_bloc.dart";

sealed class ICheckCodeState extends Equatable {
  const ICheckCodeState();
}

final class CheckCodeInitial extends ICheckCodeState {
  @override
  List<Object> get props => [];
}

final class CheckCodeLoading extends ICheckCodeState {
  @override
  List<Object> get props => [];
}

final class CheckCodeLoaded extends ICheckCodeState {
  final BaseModel<AuthModel>? authModel;

  const CheckCodeLoaded({required this.authModel});

  @override
  List<Object?> get props => [authModel];
}

final class CheckCodeFailed extends ICheckCodeState {
  final String message;

  const CheckCodeFailed(this.message);

  @override
  List<Object> get props => [message];
}

final class ResendCodeSuccess extends ICheckCodeState {
  const ResendCodeSuccess();

  @override
  List<Object?> get props => [];
}
