part of 'complete_profile_bloc.dart';

sealed class ICompleteProfileEvent extends Equatable {
  const ICompleteProfileEvent();
}

final class SubmitCompleteProfileEvent extends ICompleteProfileEvent {
  const SubmitCompleteProfileEvent(this.entity);

  final CompleteProfileEntity entity;

  @override
  List<Object?> get props => [entity];
}
