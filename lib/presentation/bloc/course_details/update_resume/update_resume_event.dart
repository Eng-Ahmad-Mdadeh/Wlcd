part of 'update_resume_bloc.dart';

sealed class IUpdateResumeEvent extends Equatable {
  const IUpdateResumeEvent();
}

final class LoadUpdateResumeEvent extends IUpdateResumeEvent {
  const LoadUpdateResumeEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
