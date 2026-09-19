part of 'resolve_playback_bloc.dart';

sealed class IResolvePlaybackState extends Equatable {
  const IResolvePlaybackState();
}

final class ResolvePlaybackInitial extends IResolvePlaybackState {
  const ResolvePlaybackInitial();
  @override
  List<Object?> get props => const [];
}

final class ResolvePlaybackLoading extends IResolvePlaybackState {
  const ResolvePlaybackLoading();
  @override
  List<Object?> get props => const [];
}

final class ResolvePlaybackLoaded extends IResolvePlaybackState {
  const ResolvePlaybackLoaded(this.resolvePlayback);

  final PlaybackModel? resolvePlayback;

  @override
  List<Object?> get props => [resolvePlayback];
}

final class ResolvePlaybackFailed extends IResolvePlaybackState {
  const ResolvePlaybackFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
