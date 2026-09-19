part of 'get_course_details_bloc.dart';

sealed class IGetCourseDetailsEvent extends Equatable {
  const IGetCourseDetailsEvent();
}

final class LoadGetCourseDetailsEvent extends IGetCourseDetailsEvent {
  const LoadGetCourseDetailsEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
