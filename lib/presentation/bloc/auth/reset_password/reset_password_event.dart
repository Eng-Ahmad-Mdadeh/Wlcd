part of 'reset_password_bloc.dart';

sealed class IResetPasswordEvent extends Equatable {
  const IResetPasswordEvent();
}

final class SubmitResetPasswordEvent extends IResetPasswordEvent {
  const SubmitResetPasswordEvent(this.entity);
  final ResetPasswordEntity entity;
  @override
  List<Object?> get props => [entity];
}
