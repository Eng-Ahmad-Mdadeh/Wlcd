part of 'list_reviews_bloc.dart';

sealed class IListReviewsEvent extends Equatable {
  const IListReviewsEvent();
}

final class LoadListReviewsEvent extends IListReviewsEvent {
  const LoadListReviewsEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
