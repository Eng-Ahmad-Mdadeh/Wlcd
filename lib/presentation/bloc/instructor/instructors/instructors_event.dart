part of 'instructors_bloc.dart';

sealed class IInstructorsEvent extends Equatable {
  const IInstructorsEvent();
}

final class LoadInstructorsEvent extends IInstructorsEvent {
  const LoadInstructorsEvent(this.entity);

  final GetInstructorsEntity entity;

  @override
  List<Object?> get props => [entity];
}
