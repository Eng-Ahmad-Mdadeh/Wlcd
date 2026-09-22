part of 'global_platforms_bloc.dart';

sealed class IGlobalPlatformsEvent extends Equatable {
  const IGlobalPlatformsEvent();
}

final class LoadGlobalPlatformsEvent extends IGlobalPlatformsEvent {
  const LoadGlobalPlatformsEvent();

  @override
  List<Object?> get props => const [];
}
