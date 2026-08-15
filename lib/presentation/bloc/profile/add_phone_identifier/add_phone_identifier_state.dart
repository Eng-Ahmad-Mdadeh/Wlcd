part of 'add_phone_identifier_bloc.dart';

sealed class IAddPhoneIdentifierState extends Equatable {
  const IAddPhoneIdentifierState();
}

final class AddPhoneIdentifierInitial extends IAddPhoneIdentifierState {
  @override
  List<Object?> get props => const [];
}

final class AddPhoneIdentifierLoading extends IAddPhoneIdentifierState {
  @override
  List<Object?> get props => const [];
}

final class AddPhoneIdentifierLoaded extends IAddPhoneIdentifierState {
  const AddPhoneIdentifierLoaded({required this.result});

  final BaseModel<PhoneIdentifierModel>? result;

  @override
  List<Object?> get props => [result];
}

final class AddPhoneIdentifierFailed extends IAddPhoneIdentifierState {
  const AddPhoneIdentifierFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
