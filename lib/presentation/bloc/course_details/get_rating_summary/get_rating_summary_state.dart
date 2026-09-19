part of 'get_rating_summary_bloc.dart';

sealed class IGetRatingSummaryState extends Equatable {
  const IGetRatingSummaryState();
}

final class GetRatingSummaryInitial extends IGetRatingSummaryState {
  const GetRatingSummaryInitial();
  @override
  List<Object?> get props => const [];
}

final class GetRatingSummaryLoading extends IGetRatingSummaryState {
  const GetRatingSummaryLoading();
  @override
  List<Object?> get props => const [];
}

final class GetRatingSummaryLoaded extends IGetRatingSummaryState {
  const GetRatingSummaryLoaded(this.getRatingSummary);

  final ContractJsonModel? getRatingSummary;

  @override
  List<Object?> get props => [getRatingSummary];
}

final class GetRatingSummaryFailed extends IGetRatingSummaryState {
  const GetRatingSummaryFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
