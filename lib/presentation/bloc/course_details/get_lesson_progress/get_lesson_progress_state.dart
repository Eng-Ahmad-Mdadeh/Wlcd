part of 'get_lesson_progress_bloc.dart';

sealed class IGetLessonProgressState extends Equatable {
  const IGetLessonProgressState();
}

final class GetLessonProgressInitial extends IGetLessonProgressState {
  const GetLessonProgressInitial();
  @override
  List<Object?> get props => const [];
}

final class GetLessonProgressLoading extends IGetLessonProgressState {
  const GetLessonProgressLoading();
  @override
  List<Object?> get props => const [];
}

final class GetLessonProgressLoaded extends IGetLessonProgressState {
  const GetLessonProgressLoaded(this.getLessonProgress);

  final ContractJsonModel? getLessonProgress;

  @override
  List<Object?> get props => [getLessonProgress];
}

final class GetLessonProgressFailed extends IGetLessonProgressState {
  const GetLessonProgressFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
