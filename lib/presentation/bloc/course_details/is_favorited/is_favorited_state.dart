part of 'is_favorited_bloc.dart';

sealed class IIsFavoritedState extends Equatable {
  const IIsFavoritedState();
}

final class IsFavoritedInitial extends IIsFavoritedState {
  const IsFavoritedInitial();
  @override
  List<Object?> get props => const [];
}

final class IsFavoritedLoading extends IIsFavoritedState {
  const IsFavoritedLoading();
  @override
  List<Object?> get props => const [];
}

final class IsFavoritedLoaded extends IIsFavoritedState {
  const IsFavoritedLoaded(this.isFavorited);

  final ContractJsonModel? isFavorited;

  @override
  List<Object?> get props => [isFavorited];
}

final class IsFavoritedFailed extends IIsFavoritedState {
  const IsFavoritedFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
