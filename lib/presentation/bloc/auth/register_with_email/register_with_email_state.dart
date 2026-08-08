part of 'register_with_email_bloc.dart';

sealed class IRegisterWithEmailState extends Equatable {
  const IRegisterWithEmailState();
}

final class RegisterWithEmailInitial extends IRegisterWithEmailState {
  @override
  List<Object?> get props => [];
}

final class RegisterWithEmailLoading extends IRegisterWithEmailState {
  @override
  List<Object?> get props => [];
}

final class RegisterWithEmailLoaded extends IRegisterWithEmailState {
  const RegisterWithEmailLoaded({required this.authModel});

  final BaseModel<AuthModel>? authModel;

  @override
  List<Object?> get props => [authModel];
}

final class RegisterWithEmailFailed extends IRegisterWithEmailState {
  const RegisterWithEmailFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
