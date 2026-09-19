part of 'get_learning_state_bloc.dart';

sealed class IGetLearningStateEvent extends Equatable {
  const IGetLearningStateEvent();
}

final class LoadGetLearningStateEvent extends IGetLearningStateEvent {
  const LoadGetLearningStateEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
