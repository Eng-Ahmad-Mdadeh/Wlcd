part of 'start_learning_bloc.dart';

sealed class IStartLearningState extends Equatable {
  const IStartLearningState();
}

final class StartLearningInitial extends IStartLearningState {
  const StartLearningInitial();
  @override
  List<Object?> get props => const [];
}

final class StartLearningLoading extends IStartLearningState {
  const StartLearningLoading();
  @override
  List<Object?> get props => const [];
}

final class StartLearningLoaded extends IStartLearningState {
  const StartLearningLoaded(this.startLearning);

  final ContractJsonModel? startLearning;

  @override
  List<Object?> get props => [startLearning];
}

final class StartLearningFailed extends IStartLearningState {
  const StartLearningFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
