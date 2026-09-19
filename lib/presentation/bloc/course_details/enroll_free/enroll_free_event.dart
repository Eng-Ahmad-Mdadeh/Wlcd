part of 'enroll_free_bloc.dart';

sealed class IEnrollFreeEvent extends Equatable {
  const IEnrollFreeEvent();
}

final class LoadEnrollFreeEvent extends IEnrollFreeEvent {
  const LoadEnrollFreeEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
