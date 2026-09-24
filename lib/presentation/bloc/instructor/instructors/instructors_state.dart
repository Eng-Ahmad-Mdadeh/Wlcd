part of 'instructors_bloc.dart';

sealed class IInstructorsState extends Equatable {
  const IInstructorsState();
}

final class InstructorsInitial extends IInstructorsState {
  const InstructorsInitial();
  @override
  List<Object?> get props => const [];
}

final class InstructorsLoading extends IInstructorsState {
  const InstructorsLoading();
  @override
  List<Object?> get props => const [];
}

final class InstructorsLoaded extends IInstructorsState {
  const InstructorsLoaded(this.instructors);
  final InstructorModel? instructors;
  @override
  List<Object?> get props => [instructors];
}

final class InstructorsFailed extends IInstructorsState {
  const InstructorsFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
