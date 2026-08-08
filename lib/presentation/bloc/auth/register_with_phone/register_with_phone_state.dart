part of 'register_with_phone_bloc.dart';

sealed class IRegisterWithPhoneState extends Equatable {
  const IRegisterWithPhoneState();
}

final class RegisterWithPhoneInitial extends IRegisterWithPhoneState {
  @override
  List<Object?> get props => [];
}

final class RegisterWithPhoneLoading extends IRegisterWithPhoneState {
  @override
  List<Object?> get props => [];
}

final class RegisterWithPhoneLoaded extends IRegisterWithPhoneState {
  const RegisterWithPhoneLoaded({required this.authModel});

  final BaseModel<AuthModel>? authModel;

  @override
  List<Object?> get props => [authModel];
}

final class RegisterWithPhoneFailed extends IRegisterWithPhoneState {
  const RegisterWithPhoneFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
