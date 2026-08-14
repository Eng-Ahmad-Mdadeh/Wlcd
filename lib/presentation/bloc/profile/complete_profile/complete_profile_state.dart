part of 'complete_profile_bloc.dart';

sealed class ICompleteProfileState extends Equatable {
  const ICompleteProfileState();
}

final class CompleteProfileInitial extends ICompleteProfileState {
  @override
  List<Object?> get props => const [];
}

final class CompleteProfileLoading extends ICompleteProfileState {
  @override
  List<Object?> get props => const [];
}

final class CompleteProfileLoaded extends ICompleteProfileState {
  const CompleteProfileLoaded({required this.profileModel});

  final BaseModel<ProfileModel>? profileModel;

  @override
  List<Object?> get props => [profileModel];
}

final class CompleteProfileFailed extends ICompleteProfileState {
  const CompleteProfileFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
