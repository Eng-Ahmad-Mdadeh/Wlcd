part of 'recommended_courses_bloc.dart';

sealed class IRecommendedCoursesState extends Equatable {
  const IRecommendedCoursesState();
}

final class RecommendedCoursesInitial extends IRecommendedCoursesState {
  const RecommendedCoursesInitial();

  @override
  List<Object?> get props => const [];
}

final class RecommendedCoursesLoading extends IRecommendedCoursesState {
  const RecommendedCoursesLoading();

  @override
  List<Object?> get props => const [];
}

final class RecommendedCoursesLoaded extends IRecommendedCoursesState {
  const RecommendedCoursesLoaded(this.courses);

  final RecommendationsModel? courses;

  @override
  List<Object?> get props => [courses];
}

final class RecommendedCoursesFailed extends IRecommendedCoursesState {
  const RecommendedCoursesFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
