part of 'request_login_otp_bloc.dart';

sealed class IRequestLoginOtpEvent extends Equatable {
  const IRequestLoginOtpEvent();
}

final class SubmitRequestLoginOtpEvent extends IRequestLoginOtpEvent {
  const SubmitRequestLoginOtpEvent(this.entity);
  final RequestLoginOtpEntity entity;
  @override
  List<Object?> get props => [entity];
}
