part of 'login_with_password_bloc.dart';

sealed class ILoginWithPasswordState extends Equatable {
  const ILoginWithPasswordState();
}
final class LoginWithPasswordInitial extends ILoginWithPasswordState {
  @override
  List<Object?> get props => [];
}
final class LoginWithPasswordLoading extends ILoginWithPasswordState {
  @override
  List<Object?> get props => [];
}
final class LoginWithPasswordLoaded extends ILoginWithPasswordState {
  const LoginWithPasswordLoaded({required this.authModel});
  final BaseModel<AuthModel>? authModel;
  @override
  List<Object?> get props => [authModel];
}
final class LoginWithPasswordFailed extends ILoginWithPasswordState {
  const LoginWithPasswordFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
