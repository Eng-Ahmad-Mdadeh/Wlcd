part of 'get_enrollment_bloc.dart';

sealed class IGetEnrollmentEvent extends Equatable {
  const IGetEnrollmentEvent();
}

final class LoadGetEnrollmentEvent extends IGetEnrollmentEvent {
  const LoadGetEnrollmentEvent(this.entity);

  final CourseDetailsEntity entity;

  @override
  List<Object?> get props => [entity];
}
