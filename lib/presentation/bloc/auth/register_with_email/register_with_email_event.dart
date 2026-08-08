part of 'register_with_email_bloc.dart';

sealed class IRegisterWithEmailEvent extends Equatable {
  const IRegisterWithEmailEvent();
}

final class SubmitRegisterWithEmailEvent extends IRegisterWithEmailEvent {
  const SubmitRegisterWithEmailEvent(this.entity);

  final RegisterWithEmailEntity entity;

  @override
  List<Object?> get props => [entity];
}
