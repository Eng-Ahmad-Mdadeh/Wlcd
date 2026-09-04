part of 'recommended_courses_bloc.dart';

sealed class IRecommendedCoursesEvent extends Equatable {
  const IRecommendedCoursesEvent();
}

final class LoadRecommendedCoursesEvent extends IRecommendedCoursesEvent {
  const LoadRecommendedCoursesEvent();

  @override
  List<Object?> get props => const [];
}
