part of 'create_download_grant_bloc.dart';

sealed class ICreateDownloadGrantEvent extends Equatable {
  const ICreateDownloadGrantEvent();
}

final class LoadCreateDownloadGrantEvent extends ICreateDownloadGrantEvent {
  const LoadCreateDownloadGrantEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
