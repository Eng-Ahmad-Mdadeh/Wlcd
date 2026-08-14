part of 'upload_avatar_bloc.dart';

sealed class IUploadAvatarEvent extends Equatable {
  const IUploadAvatarEvent();
}

final class SubmitUploadAvatarEvent extends IUploadAvatarEvent {
  const SubmitUploadAvatarEvent(this.entity);

  final UploadAvatarEntity entity;

  @override
  List<Object?> get props => [entity];
}
