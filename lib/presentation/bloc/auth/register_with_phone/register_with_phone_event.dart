part of 'register_with_phone_bloc.dart';

sealed class IRegisterWithPhoneEvent extends Equatable {
  const IRegisterWithPhoneEvent();
}

final class SubmitRegisterWithPhoneEvent extends IRegisterWithPhoneEvent {
  const SubmitRegisterWithPhoneEvent(this.entity);

  final RegisterWithPhoneEntity entity;

  @override
  List<Object?> get props => [entity];
}
