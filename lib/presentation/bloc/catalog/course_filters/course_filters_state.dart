part of 'course_filters_bloc.dart';

sealed class ICourseFiltersState extends Equatable {
  const ICourseFiltersState();
}

final class CourseFiltersInitial extends ICourseFiltersState {
  const CourseFiltersInitial();
  @override
  List<Object?> get props => const [];
}

final class CourseFiltersLoading extends ICourseFiltersState {
  const CourseFiltersLoading();
  @override
  List<Object?> get props => const [];
}

final class CourseFiltersLoaded extends ICourseFiltersState {
  const CourseFiltersLoaded(this.filters);
  final CourseFiltersModel? filters;
  @override
  List<Object?> get props => [filters];
}

final class CourseFiltersFailed extends ICourseFiltersState {
  const CourseFiltersFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
