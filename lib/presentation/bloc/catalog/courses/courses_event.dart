part of 'courses_bloc.dart';

sealed class ICoursesEvent extends Equatable {
  const ICoursesEvent();
}

final class LoadCoursesEvent extends ICoursesEvent {
  const LoadCoursesEvent(this.entity);

  final GetCoursesEntity entity;

  @override
  List<Object?> get props => [entity];
}
