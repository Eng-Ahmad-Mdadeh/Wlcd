part of 'course_details_bloc.dart';

sealed class ICourseDetailsState extends Equatable {
  const ICourseDetailsState();
}

final class CourseDetailsInitial extends ICourseDetailsState {
  const CourseDetailsInitial();
  @override List<Object?> get props => const [];
}

final class CourseDetailsLoading extends ICourseDetailsState {
  const CourseDetailsLoading(this.operation);
  final CourseDetailsOperation operation;
  @override List<Object?> get props => [operation];
}

final class CourseDetailsLoaded extends ICourseDetailsState {
  const CourseDetailsLoaded(this.operation, this.data);
  final CourseDetailsOperation operation;
  final Object? data;
  @override List<Object?> get props => [operation, data];
}

final class CourseDetailsFailed extends ICourseDetailsState {
  const CourseDetailsFailed(this.operation, this.message);
  final CourseDetailsOperation operation;
  final String message;
  @override List<Object?> get props => [operation, message];
}
