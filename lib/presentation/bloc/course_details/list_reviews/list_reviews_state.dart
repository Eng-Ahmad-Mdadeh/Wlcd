part of 'list_reviews_bloc.dart';

sealed class IListReviewsState extends Equatable {
  const IListReviewsState();
}

final class ListReviewsInitial extends IListReviewsState {
  const ListReviewsInitial();
  @override
  List<Object?> get props => const [];
}

final class ListReviewsLoading extends IListReviewsState {
  const ListReviewsLoading();
  @override
  List<Object?> get props => const [];
}

final class ListReviewsLoaded extends IListReviewsState {
  const ListReviewsLoaded(this.listReviews);

  final ContractJsonModel? listReviews;

  @override
  List<Object?> get props => [listReviews];
}

final class ListReviewsFailed extends IListReviewsState {
  const ListReviewsFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
