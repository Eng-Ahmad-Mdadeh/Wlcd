part of 'change_phone_bloc.dart';

sealed class IChangePhoneState extends Equatable {
  const IChangePhoneState();
}

final class ChangePhoneInitial extends IChangePhoneState {
  @override
  List<Object?> get props => const [];
}

final class ChangePhoneLoading extends IChangePhoneState {
  @override
  List<Object?> get props => const [];
}

final class ChangePhoneLoaded extends IChangePhoneState {
  const ChangePhoneLoaded({required this.result});

  final BaseModel<PhoneIdentifierModel>? result;

  @override
  List<Object?> get props => [result];
}

final class ChangePhoneFailed extends IChangePhoneState {
  const ChangePhoneFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
