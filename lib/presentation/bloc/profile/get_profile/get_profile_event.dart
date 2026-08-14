part of 'get_profile_bloc.dart';

sealed class IGetProfileEvent extends Equatable {
  const IGetProfileEvent();
}

final class SubmitGetProfileEvent extends IGetProfileEvent {
  const SubmitGetProfileEvent();

  @override
  List<Object?> get props => const [];
}
