part of 'resolve_playback_bloc.dart';

sealed class IResolvePlaybackEvent extends Equatable {
  const IResolvePlaybackEvent();
}

final class LoadResolvePlaybackEvent extends IResolvePlaybackEvent {
  const LoadResolvePlaybackEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
