part of 'get_completion_bloc.dart';

sealed class IGetCompletionState extends Equatable {
  const IGetCompletionState();
}

final class GetCompletionInitial extends IGetCompletionState {
  const GetCompletionInitial();
  @override
  List<Object?> get props => const [];
}

final class GetCompletionLoading extends IGetCompletionState {
  const GetCompletionLoading();
  @override
  List<Object?> get props => const [];
}

final class GetCompletionLoaded extends IGetCompletionState {
  const GetCompletionLoaded(this.getCompletion);

  final ContractJsonModel? getCompletion;

  @override
  List<Object?> get props => [getCompletion];
}

final class GetCompletionFailed extends IGetCompletionState {
  const GetCompletionFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
