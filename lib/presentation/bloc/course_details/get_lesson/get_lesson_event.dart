part of 'get_lesson_bloc.dart';

sealed class IGetLessonEvent extends Equatable {
  const IGetLessonEvent();
}

final class LoadGetLessonEvent extends IGetLessonEvent {
  const LoadGetLessonEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
