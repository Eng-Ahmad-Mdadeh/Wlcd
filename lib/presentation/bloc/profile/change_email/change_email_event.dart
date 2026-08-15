part of 'change_email_bloc.dart';

sealed class IChangeEmailEvent extends Equatable {
  const IChangeEmailEvent();
}

final class SubmitChangeEmailEvent extends IChangeEmailEvent {
  const SubmitChangeEmailEvent(this.entity);

  final ChangeEmailEntity entity;

  @override
  List<Object?> get props => [entity];
}
