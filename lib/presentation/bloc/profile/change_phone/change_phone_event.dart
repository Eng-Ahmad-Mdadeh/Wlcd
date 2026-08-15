part of 'change_phone_bloc.dart';

sealed class IChangePhoneEvent extends Equatable {
  const IChangePhoneEvent();
}

final class SubmitChangePhoneEvent extends IChangePhoneEvent {
  const SubmitChangePhoneEvent(this.entity);

  final ChangePhoneEntity entity;

  @override
  List<Object?> get props => [entity];
}
