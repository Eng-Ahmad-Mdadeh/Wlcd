part of 'featured_courses_bloc.dart';

sealed class IFeaturedCoursesEvent extends Equatable {
  const IFeaturedCoursesEvent();
}

final class LoadFeaturedCoursesEvent extends IFeaturedCoursesEvent {
  const LoadFeaturedCoursesEvent(this.entity);

  final GetFeaturedCoursesEntity entity;

  @override
  List<Object?> get props => [entity];
}
