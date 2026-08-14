part of 'upload_avatar_bloc.dart';

sealed class IUploadAvatarState extends Equatable {
  const IUploadAvatarState();
}

final class UploadAvatarInitial extends IUploadAvatarState {
  @override
  List<Object?> get props => const [];
}

final class UploadAvatarLoading extends IUploadAvatarState {
  @override
  List<Object?> get props => const [];
}

final class UploadAvatarLoaded extends IUploadAvatarState {
  const UploadAvatarLoaded({required this.profileModel});

  final BaseModel<ProfileModel>? profileModel;

  @override
  List<Object?> get props => [profileModel];
}

final class UploadAvatarFailed extends IUploadAvatarState {
  const UploadAvatarFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
