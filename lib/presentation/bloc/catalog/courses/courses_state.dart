part of 'courses_bloc.dart';

sealed class ICoursesState extends Equatable {
  const ICoursesState();
}

final class CoursesInitial extends ICoursesState {
  const CoursesInitial();

  @override
  List<Object?> get props => const [];
}

final class CoursesLoading extends ICoursesState {
  const CoursesLoading();

  @override
  List<Object?> get props => const [];
}

final class CoursesLoaded extends ICoursesState {
  const CoursesLoaded(this.courses);

  final CoursesModel? courses;

  @override
  List<Object?> get props => [courses];
}

final class CoursesFailed extends ICoursesState {
  const CoursesFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
