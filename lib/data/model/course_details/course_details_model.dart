import 'package:equatable/equatable.dart';

typedef JsonMap = Map<String, dynamic>;

/// Contract-safe projection for course discovery. Structures not documented by
/// the handoff remain JSON objects instead of being guessed by the app.
class CourseDetailsModel extends Equatable {
  const CourseDetailsModel({required this.courseId, required this.title, required this.description,
    required this.difficulty, required this.availableTabs, required this.availableActions,
    this.subtitle, this.language, this.estimatedDurationSeconds, this.thumbnailMediaId,
    this.thumbnail, this.price, this.raw = const {}});
  final String courseId;
  final String title;
  final String? subtitle;
  final String description;
  final String? language;
  final String difficulty;
  final int? estimatedDurationSeconds;
  final String? thumbnailMediaId;
  final JsonMap? thumbnail;
  final JsonMap? price;
  final List<dynamic> availableTabs;
  final List<dynamic> availableActions;
  final JsonMap raw;
  factory CourseDetailsModel.fromJson(JsonMap json) => CourseDetailsModel(
    courseId: json['courseId'] as String, title: json['title'] as String,
    subtitle: json['subtitle'] as String?, description: json['description'] as String,
    language: json['language'] as String?, difficulty: json['difficulty'] as String,
    estimatedDurationSeconds: json['estimatedDurationSeconds'] as int?,
    thumbnailMediaId: json['thumbnailMediaId'] as String?,
    thumbnail: json['thumbnail'] as JsonMap?, price: json['price'] as JsonMap?,
    availableTabs: json['availableTabs'] as List<dynamic>? ?? const [],
    availableActions: json['availableActions'] as List<dynamic>? ?? const [], raw: json);
  @override List<Object?> get props => [courseId, title, subtitle, description, language, difficulty,
    estimatedDurationSeconds, thumbnailMediaId, thumbnail, price, availableTabs, availableActions];
}

class EnrollmentModel extends Equatable {
  const EnrollmentModel({required this.enrollmentId, required this.accountId, required this.courseId,
    required this.status, required this.grantSource, required this.enrolledPublishedRevisionId,
    required this.pinSource, required this.activatedAt});
  final String enrollmentId, accountId, courseId, status, grantSource, enrolledPublishedRevisionId, pinSource;
  final DateTime activatedAt;
  factory EnrollmentModel.fromJson(JsonMap j) => EnrollmentModel(enrollmentId: j['enrollmentId'] as String,
    accountId: j['accountId'] as String, courseId: j['courseId'] as String, status: j['status'] as String,
    grantSource: j['grantSource'] as String, enrolledPublishedRevisionId: j['enrolledPublishedRevisionId'] as String,
    pinSource: j['pinSource'] as String, activatedAt: DateTime.parse(j['activatedAt'] as String));
  @override List<Object?> get props => [enrollmentId, accountId, courseId, status, grantSource,
    enrolledPublishedRevisionId, pinSource, activatedAt];
}

class LearningStateModel extends Equatable {
  const LearningStateModel({required this.enrollmentId, required this.courseId,
    required this.enrolledPublishedRevisionId, required this.learningStatus,
    required this.completedLessonCount, required this.totalRequiredLessonCount,
    required this.completionPercentage, this.lastAccessedLessonId, this.completedAt});
  final String enrollmentId, courseId, enrolledPublishedRevisionId, learningStatus;
  final int completedLessonCount, totalRequiredLessonCount, completionPercentage;
  final String? lastAccessedLessonId;
  final DateTime? completedAt;
  factory LearningStateModel.fromJson(JsonMap j) => LearningStateModel(
    enrollmentId: j['enrollmentId'] as String, courseId: j['courseId'] as String,
    enrolledPublishedRevisionId: j['enrolledPublishedRevisionId'] as String,
    learningStatus: j['learningStatus'] as String, completedLessonCount: j['completedLessonCount'] as int,
    totalRequiredLessonCount: j['totalRequiredLessonCount'] as int,
    completionPercentage: j['completionPercentage'] as int, lastAccessedLessonId: j['lastAccessedLessonId'] as String?,
    completedAt: j['completedAt'] == null ? null : DateTime.parse(j['completedAt'] as String));
  @override List<Object?> get props => [enrollmentId, courseId, enrolledPublishedRevisionId, learningStatus,
    completedLessonCount, totalRequiredLessonCount, completionPercentage, lastAccessedLessonId, completedAt];
}

class CurriculumModel extends Equatable {
  const CurriculumModel({required this.courseId, required this.enrollmentId,
    required this.enrolledPublishedRevisionId, required this.learningStatus,
    required this.completionPercentage, required this.sections, this.courseTitle, this.lastAccessedLessonId});
  final String courseId, enrollmentId, enrolledPublishedRevisionId, learningStatus;
  final String? courseTitle, lastAccessedLessonId;
  final int completionPercentage;
  final List<dynamic> sections;
  factory CurriculumModel.fromJson(JsonMap j) => CurriculumModel(courseId: j['courseId'] as String,
    enrollmentId: j['enrollmentId'] as String, enrolledPublishedRevisionId: j['enrolledPublishedRevisionId'] as String,
    courseTitle: j['courseTitle'] as String?, learningStatus: j['learningStatus'] as String,
    completionPercentage: j['completionPercentage'] as int, lastAccessedLessonId: j['lastAccessedLessonId'] as String?,
    sections: j['sections'] as List<dynamic>? ?? const []);
  @override List<Object?> get props => [courseId, enrollmentId, enrolledPublishedRevisionId, courseTitle,
    learningStatus, completionPercentage, lastAccessedLessonId, sections];
}

class LessonModel extends Equatable {
  const LessonModel({required this.courseId, required this.lessonId, required this.enrolledPublishedRevisionId,
    required this.title, required this.lessonType, required this.completionExpectation,
    this.description, this.contentDurationSeconds, this.mediaReferenceId});
  final String courseId, lessonId, enrolledPublishedRevisionId, title, lessonType, completionExpectation;
  final String? description, mediaReferenceId;
  final int? contentDurationSeconds;
  factory LessonModel.fromJson(JsonMap j) => LessonModel(courseId: j['courseId'] as String,
    lessonId: j['lessonId'] as String, enrolledPublishedRevisionId: j['enrolledPublishedRevisionId'] as String,
    title: j['title'] as String, description: j['description'] as String?, lessonType: j['lessonType'] as String,
    contentDurationSeconds: j['contentDurationSeconds'] as int?, completionExpectation: j['completionExpectation'] as String,
    mediaReferenceId: j['mediaReferenceId'] as String?);
  @override List<Object?> get props => [courseId, lessonId, enrolledPublishedRevisionId, title, description,
    lessonType, contentDurationSeconds, completionExpectation, mediaReferenceId];
}

class PlaybackModel extends Equatable {
  const PlaybackModel({required this.courseId, required this.lessonId, required this.playbackUrl,
    required this.expiresAt, required this.mediaType});
  final String courseId, lessonId, playbackUrl, mediaType;
  final DateTime expiresAt;
  factory PlaybackModel.fromJson(JsonMap j) => PlaybackModel(courseId: j['courseId'] as String,
    lessonId: j['lessonId'] as String, playbackUrl: j['playbackUrl'] as String,
    expiresAt: DateTime.parse(j['expiresAt'] as String), mediaType: j['mediaType'] as String);
  @override List<Object?> get props => [courseId, lessonId, playbackUrl, expiresAt, mediaType];
}

class ProgressEventModel extends Equatable {
  const ProgressEventModel({required this.clientEventId, required this.accepted, this.duplicateReplay,
    required this.progressSequence, required this.highestWatchedSeconds, required this.lessonProgressStatus});
  final String clientEventId, lessonProgressStatus;
  final bool accepted;
  final bool? duplicateReplay;
  final int progressSequence, highestWatchedSeconds;
  factory ProgressEventModel.fromJson(JsonMap j) => ProgressEventModel(clientEventId: j['clientEventId'] as String,
    accepted: j['accepted'] as bool, duplicateReplay: j['duplicateReplay'] as bool?,
    progressSequence: j['progressSequence'] as int, highestWatchedSeconds: j['highestWatchedSeconds'] as int,
    lessonProgressStatus: j['lessonProgressStatus'] as String);
  @override List<Object?> get props => [clientEventId, accepted, duplicateReplay, progressSequence,
    highestWatchedSeconds, lessonProgressStatus];
}

class ResumePositionModel extends Equatable {
  const ResumePositionModel({required this.enrollmentId, required this.lessonId,
    required this.lessonProgressStatus, required this.highestWatchedSeconds, this.mediaOffsetSeconds,
    required this.progressSequence, this.lastProgressAt});
  final String enrollmentId, lessonId, lessonProgressStatus;
  final int highestWatchedSeconds, progressSequence;
  final int? mediaOffsetSeconds;
  final DateTime? lastProgressAt;
  factory ResumePositionModel.fromJson(JsonMap j) => ResumePositionModel(enrollmentId: j['enrollmentId'] as String,
    lessonId: j['lessonId'] as String, lessonProgressStatus: j['lessonProgressStatus'] as String,
    highestWatchedSeconds: j['highestWatchedSeconds'] as int, mediaOffsetSeconds: j['mediaOffsetSeconds'] as int?,
    progressSequence: j['progressSequence'] as int,
    lastProgressAt: j['lastProgressAt'] == null ? null : DateTime.parse(j['lastProgressAt'] as String));
  @override List<Object?> get props => [enrollmentId, lessonId, lessonProgressStatus, highestWatchedSeconds,
    mediaOffsetSeconds, progressSequence, lastProgressAt];
}

class DownloadGrantModel extends Equatable {
  const DownloadGrantModel({required this.resourceId, required this.downloadUrl, required this.expiresAt,
    required this.mimeType, this.fileName, required this.sizeBytes, this.checksum});
  final String resourceId, downloadUrl, mimeType;
  final DateTime expiresAt;
  final String? fileName, checksum;
  final int sizeBytes;
  factory DownloadGrantModel.fromJson(JsonMap j) => DownloadGrantModel(resourceId: j['resourceId'] as String,
    downloadUrl: j['downloadUrl'] as String, expiresAt: DateTime.parse(j['expiresAt'] as String),
    mimeType: j['mimeType'] as String, fileName: j['fileName'] as String?, sizeBytes: j['sizeBytes'] as int,
    checksum: j['checksum'] as String?);
  @override List<Object?> get props => [resourceId, downloadUrl, expiresAt, mimeType, fileName, sizeBytes, checksum];
}

/// Used only where the supplied handoff deliberately does not document the
/// response schema (access, rating, favorite, progress, completion, etc.).
class ContractJsonModel extends Equatable {
  const ContractJsonModel(this.value);
  final JsonMap value;
  factory ContractJsonModel.fromJson(JsonMap json) => ContractJsonModel(json);
  @override List<Object?> get props => [value];
}
