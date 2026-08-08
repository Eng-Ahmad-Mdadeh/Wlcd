part of 'login_with_otp_bloc.dart';

sealed class ILoginWithOtpState extends Equatable {
  const ILoginWithOtpState();
}
final class LoginWithOtpInitial extends ILoginWithOtpState {
  @override
  List<Object?> get props => [];
}
final class LoginWithOtpLoading extends ILoginWithOtpState {
  @override
  List<Object?> get props => [];
}
final class LoginWithOtpLoaded extends ILoginWithOtpState {
  const LoginWithOtpLoaded({required this.authModel});
  final BaseModel<AuthModel>? authModel;
  @override
  List<Object?> get props => [authModel];
}
final class LoginWithOtpFailed extends ILoginWithOtpState {
  const LoginWithOtpFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
