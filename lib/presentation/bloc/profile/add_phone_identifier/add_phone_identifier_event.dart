part of 'add_phone_identifier_bloc.dart';

sealed class IAddPhoneIdentifierEvent extends Equatable {
  const IAddPhoneIdentifierEvent();
}

final class SubmitAddPhoneIdentifierEvent extends IAddPhoneIdentifierEvent {
  const SubmitAddPhoneIdentifierEvent(this.entity);

  final AddPhoneIdentifierEntity entity;

  @override
  List<Object?> get props => [entity];
}
