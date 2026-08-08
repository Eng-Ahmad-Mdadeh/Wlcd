part of 'verify_email_bloc.dart';

sealed class IVerifyEmailEvent extends Equatable {
  const IVerifyEmailEvent();
}

final class SubmitVerifyEmailEvent extends IVerifyEmailEvent {
  const SubmitVerifyEmailEvent(this.entity);

  final VerifyEmailEntity entity;

  @override
  List<Object?> get props => [entity];
}
