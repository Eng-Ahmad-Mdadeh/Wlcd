part of 'delete_account_bloc.dart';

sealed class IDeleteAccountEvent extends Equatable {
  const IDeleteAccountEvent();
}

class DeleteAccountEvent extends IDeleteAccountEvent {
  const DeleteAccountEvent();

  @override
  List<Object?> get props => [];
}
