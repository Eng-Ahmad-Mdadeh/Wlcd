part of 'get_rating_summary_bloc.dart';

sealed class IGetRatingSummaryEvent extends Equatable {
  const IGetRatingSummaryEvent();
}

final class LoadGetRatingSummaryEvent extends IGetRatingSummaryEvent {
  const LoadGetRatingSummaryEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
