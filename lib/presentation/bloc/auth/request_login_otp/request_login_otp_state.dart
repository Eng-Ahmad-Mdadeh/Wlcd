part of 'request_login_otp_bloc.dart';

sealed class IRequestLoginOtpState extends Equatable {
  const IRequestLoginOtpState();
}
final class RequestLoginOtpInitial extends IRequestLoginOtpState {
  @override
  List<Object?> get props => [];
}
final class RequestLoginOtpLoading extends IRequestLoginOtpState {
  @override
  List<Object?> get props => [];
}
final class RequestLoginOtpLoaded extends IRequestLoginOtpState {
  const RequestLoginOtpLoaded({required this.challenge});
  final BaseModel<PhoneOtpChallengeModel>? challenge;
  @override
  List<Object?> get props => [challenge];
}
final class RequestLoginOtpFailed extends IRequestLoginOtpState {
  const RequestLoginOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
