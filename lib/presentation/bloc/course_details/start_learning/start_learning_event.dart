part of 'start_learning_bloc.dart';

sealed class IStartLearningEvent extends Equatable {
  const IStartLearningEvent();
}

final class LoadStartLearningEvent extends IStartLearningEvent {
  const LoadStartLearningEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
