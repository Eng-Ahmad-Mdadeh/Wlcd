part of 'update_profile_bloc.dart';

sealed class IUpdateProfileState extends Equatable {
  const IUpdateProfileState();
}

final class UpdateProfileInitial extends IUpdateProfileState {
  @override
  List<Object?> get props => const [];
}

final class UpdateProfileLoading extends IUpdateProfileState {
  @override
  List<Object?> get props => const [];
}

final class UpdateProfileLoaded extends IUpdateProfileState {
  const UpdateProfileLoaded({required this.profileModel});

  final BaseModel<ProfileModel>? profileModel;

  @override
  List<Object?> get props => [profileModel];
}

final class UpdateProfileFailed extends IUpdateProfileState {
  const UpdateProfileFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
