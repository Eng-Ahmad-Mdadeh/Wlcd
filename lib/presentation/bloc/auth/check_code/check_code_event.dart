part of "check_code_bloc.dart";


sealed class ICheckCodeEvent extends Equatable {
  const ICheckCodeEvent();
}

final class CheckCodeEvent extends ICheckCodeEvent {
  final AuthEntity entity;

  const CheckCodeEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}

final class ResendCodeEvent extends ICheckCodeEvent {
  final AuthEntity entity;

  const ResendCodeEvent(this.entity);

  @override
  List<Object?> get props => [entity];
}
