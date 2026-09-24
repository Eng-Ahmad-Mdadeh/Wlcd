part of 'instructor_bloc.dart';

sealed class IInstructorState extends Equatable {
  const IInstructorState();
}

final class InstructorInitial extends IInstructorState {
  const InstructorInitial();
  @override
  List<Object?> get props => const [];
}

final class InstructorLoading extends IInstructorState {
  const InstructorLoading();
  @override
  List<Object?> get props => const [];
}

final class InstructorLoaded extends IInstructorState {
  const InstructorLoaded(this.instructor);
  final InstructorModel? instructor;
  @override
  List<Object?> get props => [instructor];
}

final class InstructorFailed extends IInstructorState {
  const InstructorFailed(this.message);
  final String message;
  @override
  List<Object?> get props => [message];
}
