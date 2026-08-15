part of 'add_email_identifier_bloc.dart';

sealed class IAddEmailIdentifierState extends Equatable {
  const IAddEmailIdentifierState();
}

final class AddEmailIdentifierInitial extends IAddEmailIdentifierState {
  @override
  List<Object?> get props => const [];
}

final class AddEmailIdentifierLoading extends IAddEmailIdentifierState {
  @override
  List<Object?> get props => const [];
}

final class AddEmailIdentifierLoaded extends IAddEmailIdentifierState {
  const AddEmailIdentifierLoaded({required this.result});

  final BaseModel<EmailIdentifierModel>? result;

  @override
  List<Object?> get props => [result];
}

final class AddEmailIdentifierFailed extends IAddEmailIdentifierState {
  const AddEmailIdentifierFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
