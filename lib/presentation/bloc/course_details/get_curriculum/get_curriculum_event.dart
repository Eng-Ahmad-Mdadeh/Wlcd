part of 'get_curriculum_bloc.dart';

sealed class IGetCurriculumEvent extends Equatable {
  const IGetCurriculumEvent();
}

final class LoadGetCurriculumEvent extends IGetCurriculumEvent {
  const LoadGetCurriculumEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
