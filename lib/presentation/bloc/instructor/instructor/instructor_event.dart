part of 'instructor_bloc.dart';

sealed class IInstructorEvent extends Equatable {
  const IInstructorEvent();
}

final class LoadInstructorEvent extends IInstructorEvent {
  const LoadInstructorEvent(this.entity);
  final GetInstructorEntity entity;
  @override
  List<Object?> get props => [entity];
}
