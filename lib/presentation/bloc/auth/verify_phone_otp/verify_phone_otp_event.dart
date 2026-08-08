part of 'verify_phone_otp_bloc.dart';

sealed class IVerifyPhoneOtpEvent extends Equatable {
  const IVerifyPhoneOtpEvent();
}

final class SubmitVerifyPhoneOtpEvent extends IVerifyPhoneOtpEvent {
  const SubmitVerifyPhoneOtpEvent(this.entity);
  final VerifyPhoneOtpEntity entity;
  @override
  List<Object?> get props => [entity];
}
