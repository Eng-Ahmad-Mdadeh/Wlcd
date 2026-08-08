part of 'register_bloc.dart';

sealed class IRegisterEvent extends Equatable {
  const IRegisterEvent();
}

final class RegisterWithEmailEvent extends IRegisterEvent {
  const RegisterWithEmailEvent(this.entity);

  final RegisterWithEmailEntity entity;

  @override
  List<Object?> get props => [entity];
}

final class RegisterWithPhoneEvent extends IRegisterEvent {
  const RegisterWithPhoneEvent(this.entity);

  final RegisterWithPhoneEntity entity;

  @override
  List<Object?> get props => [entity];
}
