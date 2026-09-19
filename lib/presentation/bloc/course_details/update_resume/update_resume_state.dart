part of 'update_resume_bloc.dart';

sealed class IUpdateResumeState extends Equatable {
  const IUpdateResumeState();
}

final class UpdateResumeInitial extends IUpdateResumeState {
  const UpdateResumeInitial();
  @override
  List<Object?> get props => const [];
}

final class UpdateResumeLoading extends IUpdateResumeState {
  const UpdateResumeLoading();
  @override
  List<Object?> get props => const [];
}

final class UpdateResumeLoaded extends IUpdateResumeState {
  const UpdateResumeLoaded(this.updateResume);

  final ResumePositionModel? updateResume;

  @override
  List<Object?> get props => [updateResume];
}

final class UpdateResumeFailed extends IUpdateResumeState {
  const UpdateResumeFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
