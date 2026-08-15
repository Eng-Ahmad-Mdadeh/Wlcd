part of 'change_email_bloc.dart';

sealed class IChangeEmailState extends Equatable {
  const IChangeEmailState();
}

final class ChangeEmailInitial extends IChangeEmailState {
  @override
  List<Object?> get props => const [];
}

final class ChangeEmailLoading extends IChangeEmailState {
  @override
  List<Object?> get props => const [];
}

final class ChangeEmailLoaded extends IChangeEmailState {
  const ChangeEmailLoaded({required this.result});

  final BaseModel<EmailIdentifierModel>? result;

  @override
  List<Object?> get props => [result];
}

final class ChangeEmailFailed extends IChangeEmailState {
  const ChangeEmailFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
