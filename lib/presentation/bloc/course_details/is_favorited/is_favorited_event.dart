part of 'is_favorited_bloc.dart';

sealed class IIsFavoritedEvent extends Equatable {
  const IIsFavoritedEvent();
}

final class LoadIsFavoritedEvent extends IIsFavoritedEvent {
  const LoadIsFavoritedEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
