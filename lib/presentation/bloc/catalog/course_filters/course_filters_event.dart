part of 'course_filters_bloc.dart';

sealed class ICourseFiltersEvent extends Equatable {
  const ICourseFiltersEvent();
}

final class LoadCourseFiltersEvent extends ICourseFiltersEvent {
  const LoadCourseFiltersEvent();

  @override
  List<Object?> get props => const [];
}
