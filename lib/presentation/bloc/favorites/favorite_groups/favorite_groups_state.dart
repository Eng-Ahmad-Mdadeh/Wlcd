part of 'favorite_groups_bloc.dart';

sealed class IFavoriteGroupsState extends Equatable {
  const IFavoriteGroupsState();
}

final class FavoriteGroupsInitial extends IFavoriteGroupsState {
  const FavoriteGroupsInitial();
  @override
  List<Object?> get props => const [];
}

final class FavoriteGroupsLoading extends IFavoriteGroupsState {
  const FavoriteGroupsLoading();
  @override
  List<Object?> get props => const [];
}

final class FavoriteGroupsLoaded extends IFavoriteGroupsState {
  const FavoriteGroupsLoaded(this.groups);
  final FavoriteGroupsModel? groups;
  @override
  List<Object?> get props => [groups];
}

final class FavoriteGroupsFailed extends IFavoriteGroupsState {
  const FavoriteGroupsFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
