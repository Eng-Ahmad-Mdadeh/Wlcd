part of 'update_profile_bloc.dart';

sealed class IUpdateProfileEvent extends Equatable {
  const IUpdateProfileEvent();
}

final class SubmitUpdateProfileEvent extends IUpdateProfileEvent {
  const SubmitUpdateProfileEvent(this.entity);

  final UpdateProfileEntity entity;

  @override
  List<Object?> get props => [entity];
}
