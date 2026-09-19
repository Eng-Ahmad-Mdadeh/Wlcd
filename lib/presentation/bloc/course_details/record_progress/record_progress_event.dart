part of 'record_progress_bloc.dart';

sealed class IRecordProgressEvent extends Equatable {
  const IRecordProgressEvent();
}

final class LoadRecordProgressEvent extends IRecordProgressEvent {
  const LoadRecordProgressEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
