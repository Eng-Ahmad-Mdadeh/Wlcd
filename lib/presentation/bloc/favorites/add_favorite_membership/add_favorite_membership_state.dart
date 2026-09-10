part of 'add_favorite_membership_bloc.dart';

sealed class IAddFavoriteMembershipState extends Equatable {
  const IAddFavoriteMembershipState();
}

final class AddFavoriteMembershipInitial
    extends IAddFavoriteMembershipState {
  const AddFavoriteMembershipInitial();
  @override
  List<Object?> get props => const [];
}

final class AddFavoriteMembershipLoading
    extends IAddFavoriteMembershipState {
  const AddFavoriteMembershipLoading();
  @override
  List<Object?> get props => const [];
}

final class AddFavoriteMembershipSucceeded
    extends IAddFavoriteMembershipState {
  const AddFavoriteMembershipSucceeded(this.membership);
  final FavoriteMembershipModel? membership;
  @override
  List<Object?> get props => [membership];
}

final class AddFavoriteMembershipFailed extends IAddFavoriteMembershipState {
  const AddFavoriteMembershipFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
