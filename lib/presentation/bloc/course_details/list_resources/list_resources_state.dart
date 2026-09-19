part of 'list_resources_bloc.dart';

sealed class IListResourcesState extends Equatable {
  const IListResourcesState();
}

final class ListResourcesInitial extends IListResourcesState {
  const ListResourcesInitial();
  @override
  List<Object?> get props => const [];
}

final class ListResourcesLoading extends IListResourcesState {
  const ListResourcesLoading();
  @override
  List<Object?> get props => const [];
}

final class ListResourcesLoaded extends IListResourcesState {
  const ListResourcesLoaded(this.listResources);

  final ContractJsonModel? listResources;

  @override
  List<Object?> get props => [listResources];
}

final class ListResourcesFailed extends IListResourcesState {
  const ListResourcesFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
