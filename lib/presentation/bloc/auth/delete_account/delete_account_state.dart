part of 'delete_account_bloc.dart';

sealed class IDeleteAccountState extends Equatable {
  const IDeleteAccountState();
}

class DeleteAccountInitial extends IDeleteAccountState {
  @override
  List<Object?> get props => [];
}

class DeleteAccountLoading extends IDeleteAccountState {
  @override
  List<Object?> get props => [];
}

class DeleteAccountLoaded extends IDeleteAccountState {
  final BaseModel<DeleteAccountModel>? response;

  const DeleteAccountLoaded({required this.response});

  @override
  List<Object?> get props => [response];
}

class DeleteAccountFailed extends IDeleteAccountState {
  final String message;

  const DeleteAccountFailed(this.message);

  @override
  List<Object?> get props => [message];
}
