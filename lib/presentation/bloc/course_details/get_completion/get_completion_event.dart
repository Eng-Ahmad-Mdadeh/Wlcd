part of 'get_completion_bloc.dart';

sealed class IGetCompletionEvent extends Equatable {
  const IGetCompletionEvent();
}

final class LoadGetCompletionEvent extends IGetCompletionEvent {
  const LoadGetCompletionEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
