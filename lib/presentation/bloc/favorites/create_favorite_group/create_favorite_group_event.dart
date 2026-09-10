part of 'create_favorite_group_bloc.dart';

sealed class ICreateFavoriteGroupEvent extends Equatable {
  const ICreateFavoriteGroupEvent();
}

final class SubmitCreateFavoriteGroupEvent
    extends ICreateFavoriteGroupEvent {
  const SubmitCreateFavoriteGroupEvent(this.entity);
  final FavoritesEntity entity;

  @override
  List<Object?> get props => [entity];
}
