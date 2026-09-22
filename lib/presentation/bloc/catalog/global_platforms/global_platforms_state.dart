part of 'global_platforms_bloc.dart';

sealed class IGlobalPlatformsState extends Equatable {
  const IGlobalPlatformsState();
}

final class GlobalPlatformsInitial extends IGlobalPlatformsState {
  const GlobalPlatformsInitial();
  @override
  List<Object?> get props => const [];
}

final class GlobalPlatformsLoading extends IGlobalPlatformsState {
  const GlobalPlatformsLoading();
  @override
  List<Object?> get props => const [];
}

final class GlobalPlatformsLoaded extends IGlobalPlatformsState {
  const GlobalPlatformsLoaded(this.platforms);
  final GlobalPlatformsModel? platforms;
  @override
  List<Object?> get props => [platforms];
}

final class GlobalPlatformsFailed extends IGlobalPlatformsState {
  const GlobalPlatformsFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
