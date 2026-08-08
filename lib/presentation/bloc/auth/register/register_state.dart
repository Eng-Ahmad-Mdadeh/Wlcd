part of 'register_bloc.dart';

sealed class IRegisterState extends Equatable {
  const IRegisterState();
}

final class RegisterInitial extends IRegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterLoading extends IRegisterState {
  @override
  List<Object?> get props => [];
}

final class RegisterLoaded extends IRegisterState {
  const RegisterLoaded({required this.authModel});

  final BaseModel<AuthModel>? authModel;

  @override
  List<Object?> get props => [authModel];
}

final class RegisterFailed extends IRegisterState {
  const RegisterFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
