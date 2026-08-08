part of 'request_phone_otp_bloc.dart';

sealed class IRequestPhoneOtpEvent extends Equatable {
  const IRequestPhoneOtpEvent();
}

final class SubmitRequestPhoneOtpEvent extends IRequestPhoneOtpEvent {
  const SubmitRequestPhoneOtpEvent(this.entity);

  final RequestPhoneOtpEntity entity;

  @override
  List<Object?> get props => [entity];
}
