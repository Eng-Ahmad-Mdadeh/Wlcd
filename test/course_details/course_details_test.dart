import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/presentation/cubit/course_details/course_details_entity_cubit.dart';

void main() {
  test('course discovery preserves contract-driven tabs and actions', () {
    final model = CourseDetailsModel.fromJson({
      'courseId': 'course-id',
      'title': 'Course',
      'description': 'Description',
      'difficulty': 'beginner',
      'availableTabs': [
        {'type': 'overview'},
      ],
      'availableActions': [
        {'type': 'enroll'},
      ],
    });

    expect(model.availableTabs.single, {'type': 'overview'});
    expect(model.availableActions.single, {'type': 'enroll'});
  });

  test('progress body keeps one client event id and UTC observation time', () {
    final entity = CourseDetailsEntity(
      clientEventId: 'event-id',
      eventType: 'watched',
      watchedSeconds: 30,
      observedAt: DateTime.parse('2026-09-18T10:00:00+02:00'),
    );

    expect(entity.progressBody, {
      'clientEventId': 'event-id',
      'eventType': 'watched',
      'watchedSeconds': 30,
      'observedAt': '2026-09-18T08:00:00.000Z',
    });
  });

  test('entity cubit stores opaque journey identifiers', () async {
    final cubit = CourseDetailsEntityCubit();
    addTearDown(cubit.close);

    cubit.setCourseId('opaque-course');
    cubit.setLessonId('opaque-lesson');
    cubit.setEnrollmentId('opaque-enrollment');

    expect(cubit.state.courseId, 'opaque-course');
    expect(cubit.state.lessonId, 'opaque-lesson');
    expect(cubit.state.enrollmentId, 'opaque-enrollment');
  });
}
