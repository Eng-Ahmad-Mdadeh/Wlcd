part of 'add_favorite_membership_bloc.dart';

sealed class IAddFavoriteMembershipEvent extends Equatable {
  const IAddFavoriteMembershipEvent();
}

final class SubmitAddFavoriteMembershipEvent
    extends IAddFavoriteMembershipEvent {
  const SubmitAddFavoriteMembershipEvent(this.entity);
  final FavoritesEntity entity;

  @override
  List<Object?> get props => [entity];
}
