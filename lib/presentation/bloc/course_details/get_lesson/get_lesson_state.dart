part of 'get_lesson_bloc.dart';

sealed class IGetLessonState extends Equatable {
  const IGetLessonState();
}

final class GetLessonInitial extends IGetLessonState {
  const GetLessonInitial();
  @override
  List<Object?> get props => const [];
}

final class GetLessonLoading extends IGetLessonState {
  const GetLessonLoading();
  @override
  List<Object?> get props => const [];
}

final class GetLessonLoaded extends IGetLessonState {
  const GetLessonLoaded(this.getLesson);

  final LessonModel? getLesson;

  @override
  List<Object?> get props => [getLesson];
}

final class GetLessonFailed extends IGetLessonState {
  const GetLessonFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
