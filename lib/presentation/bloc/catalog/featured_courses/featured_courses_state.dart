part of 'featured_courses_bloc.dart';

sealed class IFeaturedCoursesState extends Equatable {
  const IFeaturedCoursesState();
}

final class FeaturedCoursesInitial extends IFeaturedCoursesState {
  const FeaturedCoursesInitial();

  @override
  List<Object?> get props => const [];
}

final class FeaturedCoursesLoading extends IFeaturedCoursesState {
  const FeaturedCoursesLoading();

  @override
  List<Object?> get props => const [];
}

final class FeaturedCoursesLoaded extends IFeaturedCoursesState {
  const FeaturedCoursesLoaded(this.courses);

  final CoursesModel? courses;

  @override
  List<Object?> get props => [courses];
}

final class FeaturedCoursesFailed extends IFeaturedCoursesState {
  const FeaturedCoursesFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
