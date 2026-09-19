part of 'get_lesson_progress_bloc.dart';

sealed class IGetLessonProgressEvent extends Equatable {
  const IGetLessonProgressEvent();
}

final class LoadGetLessonProgressEvent extends IGetLessonProgressEvent {
  const LoadGetLessonProgressEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
