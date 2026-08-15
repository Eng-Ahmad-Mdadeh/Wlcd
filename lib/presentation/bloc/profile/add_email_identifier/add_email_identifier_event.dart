part of 'add_email_identifier_bloc.dart';

sealed class IAddEmailIdentifierEvent extends Equatable {
  const IAddEmailIdentifierEvent();
}

final class SubmitAddEmailIdentifierEvent extends IAddEmailIdentifierEvent {
  const SubmitAddEmailIdentifierEvent(this.entity);

  final AddEmailIdentifierEntity entity;

  @override
  List<Object?> get props => [entity];
}
