part of 'verify_phone_otp_bloc.dart';

sealed class IVerifyPhoneOtpState extends Equatable {
  const IVerifyPhoneOtpState();
}
final class VerifyPhoneOtpInitial extends IVerifyPhoneOtpState {
  @override
  List<Object?> get props => [];
}
final class VerifyPhoneOtpLoading extends IVerifyPhoneOtpState {
  @override
  List<Object?> get props => [];
}
final class VerifyPhoneOtpLoaded extends IVerifyPhoneOtpState {
  const VerifyPhoneOtpLoaded({required this.verification});
  final BaseModel<PhoneOtpVerificationModel>? verification;
  @override
  List<Object?> get props => [verification];
}
final class VerifyPhoneOtpFailed extends IVerifyPhoneOtpState {
  const VerifyPhoneOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
