part of 'verify_email_bloc.dart';

sealed class IVerifyEmailState extends Equatable {
  const IVerifyEmailState();
}

final class VerifyEmailInitial extends IVerifyEmailState {
  @override
  List<Object?> get props => [];
}

final class VerifyEmailLoading extends IVerifyEmailState {
  @override
  List<Object?> get props => [];
}

final class VerifyEmailLoaded extends IVerifyEmailState {
  const VerifyEmailLoaded({required this.verification});

  final BaseModel<VerifyEmailModel>? verification;

  @override
  List<Object?> get props => [verification];
}

final class VerifyEmailFailed extends IVerifyEmailState {
  const VerifyEmailFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
