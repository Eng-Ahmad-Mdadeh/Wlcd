part of 'get_access_status_bloc.dart';

sealed class IGetAccessStatusEvent extends Equatable {
  const IGetAccessStatusEvent();
}

final class LoadGetAccessStatusEvent extends IGetAccessStatusEvent {
  const LoadGetAccessStatusEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
