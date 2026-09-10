part of 'favorite_memberships_bloc.dart';

sealed class IFavoriteMembershipsState extends Equatable {
  const IFavoriteMembershipsState();
}

final class FavoriteMembershipsInitial extends IFavoriteMembershipsState {
  const FavoriteMembershipsInitial();
  @override
  List<Object?> get props => const [];
}

final class FavoriteMembershipsLoading extends IFavoriteMembershipsState {
  const FavoriteMembershipsLoading();
  @override
  List<Object?> get props => const [];
}

final class FavoriteMembershipsLoaded extends IFavoriteMembershipsState {
  const FavoriteMembershipsLoaded(this.memberships);
  final FavoriteMembershipsModel? memberships;
  @override
  List<Object?> get props => [memberships];
}

final class FavoriteMembershipsFailed extends IFavoriteMembershipsState {
  const FavoriteMembershipsFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
