import 'package:flutter_test/flutter_test.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';

void main() {
  test(
    'course details preserves optional fields, defaults and raw response',
    () {
      final json = <String, dynamic>{
        'courseId': 'course',
        'title': 'دورة',
        'description': 'Description',
        'difficulty': 'beginner',
        'estimatedDurationSeconds': 120,
        'thumbnail': {'url': 'https://example.com/image.png'},
        'price': {'amount': '0.00'},
        'undocumentedField': {'enabled': true},
      };
      final model = CourseDetailsModel.fromJson(json);
      expect(model.courseId, 'course');
      expect(model.subtitle, isNull);
      expect(model.estimatedDurationSeconds, 120);
      expect(model.thumbnail?['url'], 'https://example.com/image.png');
      expect(model.price?['amount'], '0.00');
      expect(model.availableTabs, isEmpty);
      expect(model.availableActions, isEmpty);
      expect(model.raw, json);

      final populated = CourseDetailsModel.fromJson({
        ...json,
        'availableTabs': [
          'overview',
          {'id': 'curriculum'},
        ],
        'availableActions': ['enroll'],
      });
      expect(populated.availableTabs, [
        'overview',
        {'id': 'curriculum'},
      ]);
      expect(populated.availableActions, ['enroll']);
    },
  );

  test('enrollment and playback parse ISO timestamps', () {
    final enrollment = EnrollmentModel.fromJson({
      'enrollmentId': 'enrollment',
      'accountId': 'account',
      'courseId': 'course',
      'status': 'active',
      'grantSource': 'free',
      'enrolledPublishedRevisionId': 'revision',
      'pinSource': 'published',
      'activatedAt': '2026-09-21T01:55:22.000Z',
    });
    expect(enrollment.activatedAt, DateTime.utc(2026, 9, 21, 1, 55, 22));
    final playback = PlaybackModel.fromJson({
      'courseId': 'course',
      'lessonId': 'lesson',
      'playbackUrl': 'https://example.com/video',
      'expiresAt': '2026-09-21T02:00:00.000Z',
      'mediaType': 'video',
    });
    expect(playback.expiresAt, DateTime.utc(2026, 9, 21, 2));
  });

  test('learning state and resume accept nullable timestamps', () {
    final learning = LearningStateModel.fromJson({
      'enrollmentId': 'enrollment',
      'courseId': 'course',
      'enrolledPublishedRevisionId': 'revision',
      'learningStatus': 'started',
      'completedLessonCount': 1,
      'totalRequiredLessonCount': 4,
      'completionPercentage': 25,
      'completedAt': null,
    });
    expect(learning.completedAt, isNull);
    expect(learning.lastAccessedLessonId, isNull);
    expect(learning.completionPercentage, 25);
    final resume = ResumePositionModel.fromJson({
      'enrollmentId': 'enrollment',
      'lessonId': 'lesson',
      'lessonProgressStatus': 'started',
      'highestWatchedSeconds': 20,
      'progressSequence': 2,
    });
    expect(resume.mediaOffsetSeconds, isNull);
    expect(resume.lastProgressAt, isNull);
  });

  test('curriculum preserves sections and defaults missing sections', () {
    final json = <String, dynamic>{
      'courseId': 'course',
      'enrollmentId': 'enrollment',
      'enrolledPublishedRevisionId': 'revision',
      'learningStatus': 'started',
      'completionPercentage': 0,
    };
    expect(CurriculumModel.fromJson(json).sections, isEmpty);
    final sections = [
      {
        'sectionId': 'section',
        'lessons': [
          {'lessonId': 'lesson'},
        ],
      },
    ];
    expect(
      CurriculumModel.fromJson({...json, 'sections': sections}).sections,
      sections,
    );
  });

  test('lesson and progress retain required and nullable fields', () {
    final lesson = LessonModel.fromJson({
      'courseId': 'course',
      'lessonId': 'lesson',
      'enrolledPublishedRevisionId': 'revision',
      'title': 'Lesson',
      'lessonType': 'video',
      'completionExpectation': 'watch',
    });
    expect(lesson.description, isNull);
    expect(lesson.contentDurationSeconds, isNull);
    expect(lesson.mediaReferenceId, isNull);
    final progress = ProgressEventModel.fromJson({
      'clientEventId': 'event',
      'accepted': true,
      'progressSequence': 2,
      'highestWatchedSeconds': 20,
      'lessonProgressStatus': 'started',
    });
    expect(progress.accepted, isTrue);
    expect(progress.duplicateReplay, isNull);
    expect(progress.highestWatchedSeconds, 20);
  });

  test('download grants parse metadata and nullable fields', () {
    final grant = DownloadGrantModel.fromJson({
      'resourceId': 'resource',
      'downloadUrl': 'https://example.com/file',
      'expiresAt': '2026-09-21T02:00:00.000Z',
      'mimeType': 'application/pdf',
      'sizeBytes': 1024,
    });
    expect(grant.expiresAt, DateTime.utc(2026, 9, 21, 2));
    expect(grant.sizeBytes, 1024);
    expect(grant.fileName, isNull);
    expect(grant.checksum, isNull);
  });

  test('contract JSON keeps the complete response including a value key', () {
    final json = <String, dynamic>{
      'value': 7,
      'data': [
        {'id': 'review'},
      ],
    };
    expect(ContractJsonModel.fromJson(json).value, json);
  });
}
