part of 'complete_lesson_bloc.dart';

sealed class ICompleteLessonState extends Equatable {
  const ICompleteLessonState();
}

final class CompleteLessonInitial extends ICompleteLessonState {
  const CompleteLessonInitial();
  @override
  List<Object?> get props => const [];
}

final class CompleteLessonLoading extends ICompleteLessonState {
  const CompleteLessonLoading();
  @override
  List<Object?> get props => const [];
}

final class CompleteLessonLoaded extends ICompleteLessonState {
  const CompleteLessonLoaded(this.completeLesson);

  final ContractJsonModel? completeLesson;

  @override
  List<Object?> get props => [completeLesson];
}

final class CompleteLessonFailed extends ICompleteLessonState {
  const CompleteLessonFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
