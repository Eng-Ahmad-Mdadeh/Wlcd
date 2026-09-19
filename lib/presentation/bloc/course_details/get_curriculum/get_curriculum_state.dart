part of 'get_curriculum_bloc.dart';

sealed class IGetCurriculumState extends Equatable {
  const IGetCurriculumState();
}

final class GetCurriculumInitial extends IGetCurriculumState {
  const GetCurriculumInitial();
  @override
  List<Object?> get props => const [];
}

final class GetCurriculumLoading extends IGetCurriculumState {
  const GetCurriculumLoading();
  @override
  List<Object?> get props => const [];
}

final class GetCurriculumLoaded extends IGetCurriculumState {
  const GetCurriculumLoaded(this.getCurriculum);

  final CurriculumModel? getCurriculum;

  @override
  List<Object?> get props => [getCurriculum];
}

final class GetCurriculumFailed extends IGetCurriculumState {
  const GetCurriculumFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
