part of 'favorite_groups_bloc.dart';

sealed class IFavoriteGroupsEvent extends Equatable {
  const IFavoriteGroupsEvent();
}

final class LoadFavoriteGroupsEvent extends IFavoriteGroupsEvent {
  const LoadFavoriteGroupsEvent();

  @override
  List<Object?> get props => const [];
}
