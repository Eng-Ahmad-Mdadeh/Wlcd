part of 'login_bloc.dart';

sealed class ILoginState extends Equatable {
  const ILoginState();
}

final class LoginInitial extends ILoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoading extends ILoginState {
  @override
  List<Object> get props => [];
}

final class LoginLoaded extends ILoginState {
  final BaseModel<AuthModel>? authModel;

  const LoginLoaded({required this.authModel});

  @override
  List<Object?> get props => [authModel];
}

final class LoginFailed extends ILoginState {
  final String message;

  const LoginFailed(this.message);

  @override
  List<Object> get props => [message];
}
