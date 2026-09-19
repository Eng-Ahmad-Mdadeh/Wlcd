part of 'course_details_bloc.dart';

sealed class ICourseDetailsEvent extends Equatable {
  const ICourseDetailsEvent();
}

final class LoadCourseDetailsEvent extends ICourseDetailsEvent {
  const LoadCourseDetailsEvent(this.operation, this.entity);
  final CourseDetailsOperation operation;
  final CourseDetailsEntity entity;
  @override List<Object?> get props => [operation, entity];
}
