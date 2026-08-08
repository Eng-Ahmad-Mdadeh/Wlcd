part of 'login_with_otp_bloc.dart';

sealed class ILoginWithOtpEvent extends Equatable {
  const ILoginWithOtpEvent();
}

final class SubmitLoginWithOtpEvent extends ILoginWithOtpEvent {
  const SubmitLoginWithOtpEvent(this.entity);
  final LoginWithOtpEntity entity;
  @override
  List<Object?> get props => [entity];
}
