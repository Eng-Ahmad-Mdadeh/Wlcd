import 'package:equatable/equatable.dart';

/// Immutable input shared by the course-detail and entitled-learning journeys.
/// IDs are intentionally kept opaque; this client never parses ULIDs.
class CourseDetailsEntity extends Equatable {
  const CourseDetailsEntity({
    this.courseId,
    this.lessonId,
    this.enrollmentId,
    this.resourceId,
    this.cursor,
    this.limit = 20,
    this.locale,
    this.idempotencyKey,
    this.clientEnrollmentKey,
    this.clientEventId,
    this.eventType,
    this.watchedSeconds,
    this.observedAt,
    this.mediaOffsetSeconds,
    this.contentMarker,
  });

  final String? courseId;
  final String? lessonId;
  final String? enrollmentId;
  final String? resourceId;
  final String? cursor;
  final int limit;
  final String? locale;
  final String? idempotencyKey;
  final String? clientEnrollmentKey;
  final String? clientEventId;
  final String? eventType;
  final int? watchedSeconds;
  final DateTime? observedAt;
  final int? mediaOffsetSeconds;
  final String? contentMarker;

  Map<String, dynamic> get paginationQuery => {
    if (cursor != null) 'cursor': cursor,
    'limit': limit,
  };

  Map<String, dynamic> get enrollmentBody => {
    'clientEnrollmentKey': clientEnrollmentKey,
  };

  Map<String, dynamic> get clientEventBody => {
    'clientEventId': clientEventId,
  };

  Map<String, dynamic> get progressBody => {
    'clientEventId': clientEventId,
    'eventType': eventType,
    'watchedSeconds': watchedSeconds,
    'observedAt': observedAt?.toUtc().toIso8601String(),
  };

  Map<String, dynamic> get resumeBody => {
    'mediaOffsetSeconds': mediaOffsetSeconds,
    if (contentMarker != null) 'contentMarker': contentMarker,
  };

  CourseDetailsEntity copyWith({
    String? courseId,
    String? lessonId,
    String? enrollmentId,
    String? resourceId,
    String? cursor,
    int? limit,
    String? locale,
    String? idempotencyKey,
    String? clientEnrollmentKey,
    String? clientEventId,
    String? eventType,
    int? watchedSeconds,
    DateTime? observedAt,
    int? mediaOffsetSeconds,
    String? contentMarker,
    bool clearCursor = false,
  }) => CourseDetailsEntity(
    courseId: courseId ?? this.courseId,
    lessonId: lessonId ?? this.lessonId,
    enrollmentId: enrollmentId ?? this.enrollmentId,
    resourceId: resourceId ?? this.resourceId,
    cursor: clearCursor ? null : cursor ?? this.cursor,
    limit: limit ?? this.limit,
    locale: locale ?? this.locale,
    idempotencyKey: idempotencyKey ?? this.idempotencyKey,
    clientEnrollmentKey: clientEnrollmentKey ?? this.clientEnrollmentKey,
    clientEventId: clientEventId ?? this.clientEventId,
    eventType: eventType ?? this.eventType,
    watchedSeconds: watchedSeconds ?? this.watchedSeconds,
    observedAt: observedAt ?? this.observedAt,
    mediaOffsetSeconds: mediaOffsetSeconds ?? this.mediaOffsetSeconds,
    contentMarker: contentMarker ?? this.contentMarker,
  );

  @override
  List<Object?> get props => [courseId, lessonId, enrollmentId, resourceId, cursor, limit, locale,
    idempotencyKey, clientEnrollmentKey, clientEventId, eventType, watchedSeconds, observedAt,
    mediaOffsetSeconds, contentMarker];
}
