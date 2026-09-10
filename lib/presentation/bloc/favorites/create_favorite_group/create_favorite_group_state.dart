part of 'create_favorite_group_bloc.dart';

sealed class ICreateFavoriteGroupState extends Equatable {
  const ICreateFavoriteGroupState();
}

final class CreateFavoriteGroupInitial extends ICreateFavoriteGroupState {
  const CreateFavoriteGroupInitial();
  @override
  List<Object?> get props => const [];
}

final class CreateFavoriteGroupLoading extends ICreateFavoriteGroupState {
  const CreateFavoriteGroupLoading();
  @override
  List<Object?> get props => const [];
}

final class CreateFavoriteGroupSucceeded extends ICreateFavoriteGroupState {
  const CreateFavoriteGroupSucceeded(this.group);
  final FavoriteGroupModel? group;
  @override
  List<Object?> get props => [group];
}

final class CreateFavoriteGroupFailed extends ICreateFavoriteGroupState {
  const CreateFavoriteGroupFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
