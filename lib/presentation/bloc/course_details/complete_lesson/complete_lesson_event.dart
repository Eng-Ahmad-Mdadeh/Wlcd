part of 'complete_lesson_bloc.dart';

sealed class ICompleteLessonEvent extends Equatable {
  const ICompleteLessonEvent();
}

final class LoadCompleteLessonEvent extends ICompleteLessonEvent {
  const LoadCompleteLessonEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
