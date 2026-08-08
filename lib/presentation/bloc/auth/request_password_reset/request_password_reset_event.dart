part of 'request_password_reset_bloc.dart';

sealed class IRequestPasswordResetEvent extends Equatable {
  const IRequestPasswordResetEvent();
}

final class SubmitRequestPasswordResetEvent extends IRequestPasswordResetEvent {
  const SubmitRequestPasswordResetEvent(this.entity);
  final RequestPasswordResetEntity entity;
  @override
  List<Object?> get props => [entity];
}
