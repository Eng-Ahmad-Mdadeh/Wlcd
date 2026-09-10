part of 'favorite_memberships_bloc.dart';

sealed class IFavoriteMembershipsEvent extends Equatable {
  const IFavoriteMembershipsEvent();
}

final class LoadFavoriteMembershipsEvent
    extends IFavoriteMembershipsEvent {
  const LoadFavoriteMembershipsEvent(this.entity);
  final FavoritesEntity entity;

  @override
  List<Object?> get props => [entity];
}
