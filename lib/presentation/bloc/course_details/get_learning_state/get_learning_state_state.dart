part of 'get_learning_state_bloc.dart';

sealed class IGetLearningStateState extends Equatable {
  const IGetLearningStateState();
}

final class GetLearningStateInitial extends IGetLearningStateState {
  const GetLearningStateInitial();
  @override
  List<Object?> get props => const [];
}

final class GetLearningStateLoading extends IGetLearningStateState {
  const GetLearningStateLoading();
  @override
  List<Object?> get props => const [];
}

final class GetLearningStateLoaded extends IGetLearningStateState {
  const GetLearningStateLoaded(this.getLearningState);

  final LearningStateModel? getLearningState;

  @override
  List<Object?> get props => [getLearningState];
}

final class GetLearningStateFailed extends IGetLearningStateState {
  const GetLearningStateFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
