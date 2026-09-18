import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';

/// Holds form/navigation values separately from request lifecycle state.
class CourseDetailsEntityCubit extends Cubit<CourseDetailsEntity> {
  CourseDetailsEntityCubit() : super(const CourseDetailsEntity());

  void setCourseId(String value) => emit(state.copyWith(courseId: value));
  void setLessonId(String value) => emit(state.copyWith(lessonId: value));
  void setEnrollmentId(String value) => emit(state.copyWith(enrollmentId: value));
  void setResourceId(String value) => emit(state.copyWith(resourceId: value));
  void setCursor(String? value) => emit(state.copyWith(cursor: value, clearCursor: value == null));
  void setLocale(String value) => emit(state.copyWith(locale: value));
  void setIdempotency({required String key, required String clientEnrollmentKey}) => emit(
    state.copyWith(idempotencyKey: key, clientEnrollmentKey: clientEnrollmentKey));
  void setProgressEvent({required String clientEventId, required String eventType,
      required int watchedSeconds, required DateTime observedAt}) => emit(state.copyWith(
    clientEventId: clientEventId, eventType: eventType, watchedSeconds: watchedSeconds,
    observedAt: observedAt));
  void setResumePosition(int seconds, {String? contentMarker}) => emit(
    state.copyWith(mediaOffsetSeconds: seconds, contentMarker: contentMarker));
  void reset() => emit(const CourseDetailsEntity());
}
