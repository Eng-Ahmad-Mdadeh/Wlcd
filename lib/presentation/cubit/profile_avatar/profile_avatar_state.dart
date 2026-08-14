part of 'profile_avatar_cubit.dart';

sealed class ProfileAvatarState extends Equatable {
  const ProfileAvatarState();
}

final class ProfileAvatarInitial extends ProfileAvatarState {
  const ProfileAvatarInitial();
  @override
  List<Object?> get props => const [];
}

final class ProfileAvatarUploading extends ProfileAvatarState {
  const ProfileAvatarUploading();
  @override
  List<Object?> get props => const [];
}

final class ProfileAvatarUploaded extends ProfileAvatarState {
  const ProfileAvatarUploaded(this.profile);
  final ProfileModel? profile;
  @override
  List<Object?> get props => [profile];
}

final class ProfileAvatarFailure extends ProfileAvatarState {
  const ProfileAvatarFailure(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
