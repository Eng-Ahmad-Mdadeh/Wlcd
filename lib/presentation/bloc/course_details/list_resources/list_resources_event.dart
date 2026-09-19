part of 'list_resources_bloc.dart';

sealed class IListResourcesEvent extends Equatable {
  const IListResourcesEvent();
}

final class LoadListResourcesEvent extends IListResourcesEvent {
  const LoadListResourcesEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
