import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';

@injectable
class CourseDetailsRemoteDataSource extends BaseRemoteDataSource<Object> {
  CourseDetailsRemoteDataSource() : super('');

  Future<Either<AppException, BaseModel<T>?>> _get<T>(
    String path,
    T Function(JsonMap) parser, {
    Map<String, dynamic>? query,
    Map<String, dynamic>? headers,
    bool authenticated = true,
  }) => fetchDataAs<T>(
    endpoint: path,
    queryParams: query,
    headers: headers,
    includeAuthorization: authenticated,
    fromJsonT: (json) => parser(json as JsonMap),
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<T>?>> _post<T>(
    String path,
    T Function(JsonMap) parser, {
    Map<String, dynamic>? data,
    Map<String, dynamic>? headers,
  }) => postDataAs<T>(
    endpoint: path,
    data: data,
    headers: headers,
    isFormDate: false,
    fromJsonT: (json) => parser(json as JsonMap),
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<CourseDetailsModel>?>> getCourseDetails(CourseDetailsEntity e) => _get(
    '/courses/${e.courseId}',
    CourseDetailsModel.fromJson,
    headers: {if (e.locale != null) 'Accept-Language': e.locale},
    authenticated: true,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getRatingSummary(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/rating-summary', ContractJsonModel.fromJson, authenticated: false);

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> listReviews(CourseDetailsEntity e) => _get(
    '/courses/${e.courseId}/reviews',
    ContractJsonModel.fromJson,
    query: e.paginationQuery,
    authenticated: false,
  );

  Future<Either<AppException, BaseModel<EnrollmentModel>?>> getEnrollment(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/enrollment', EnrollmentModel.fromJson);

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getAccessStatus(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/access-status', ContractJsonModel.fromJson);

  Future<Either<AppException, BaseModel<EnrollmentModel>?>> enrollFree(CourseDetailsEntity e) => _post(
    '/courses/${e.courseId}/enrollments',
    EnrollmentModel.fromJson,
    data: e.enrollmentBody,
    headers: {if (e.idempotencyKey != null) 'Idempotency-Key': e.idempotencyKey},
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getCheckoutQuote(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/checkout-quote', ContractJsonModel.fromJson);

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> isFavorited(CourseDetailsEntity e) =>
      _get('/accounts/me/favorites/courses/${e.courseId}', ContractJsonModel.fromJson);

  Future<Either<AppException, BaseModel<LearningStateModel>?>> getLearningState(CourseDetailsEntity e) =>
      _get('/enrollments/${e.enrollmentId}/learning-state', LearningStateModel.fromJson);

  Future<Either<AppException, BaseModel<CurriculumModel>?>> getCurriculum(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/learning-curriculum', CurriculumModel.fromJson);

  Future<Either<AppException, BaseModel<LessonModel>?>> getLesson(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/lessons/${e.lessonId}', LessonModel.fromJson);

  Future<Either<AppException, BaseModel<PlaybackModel>?>> resolvePlayback(CourseDetailsEntity e) =>
      _post('/courses/${e.courseId}/lessons/${e.lessonId}/playback', PlaybackModel.fromJson);

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getLessonProgress(CourseDetailsEntity e) =>
      _get('/enrollments/${e.enrollmentId}/lessons/${e.lessonId}/progress', ContractJsonModel.fromJson);

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> startLearning(CourseDetailsEntity e) =>
      _post('/enrollments/${e.enrollmentId}/learning/start', ContractJsonModel.fromJson, data: e.clientEventBody);

  Future<Either<AppException, BaseModel<ProgressEventModel>?>> recordProgress(CourseDetailsEntity e) => _post(
    '/enrollments/${e.enrollmentId}/lessons/${e.lessonId}/progress-events',
    ProgressEventModel.fromJson,
    data: e.progressBody,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> completeLesson(CourseDetailsEntity e) => _post(
    '/enrollments/${e.enrollmentId}/lessons/${e.lessonId}/complete',
    ContractJsonModel.fromJson,
    data: e.clientEventBody,
  );

  Future<Either<AppException, BaseModel<ResumePositionModel>?>> updateResume(CourseDetailsEntity e) => patchData(
    endpoint: '/enrollments/${e.enrollmentId}/lessons/${e.lessonId}/resume-position',
    data: e.resumeBody,
    isFormData: false,
    fromJsonT: (json) => ResumePositionModel.fromJson(json as JsonMap),
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getCompletion(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/learning-completion', ContractJsonModel.fromJson);

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> listResources(CourseDetailsEntity e) =>
      _get('/courses/${e.courseId}/learning-resources', ContractJsonModel.fromJson);

  Future<Either<AppException, BaseModel<DownloadGrantModel>?>> createDownloadGrant(CourseDetailsEntity e) =>
      _post('/learning/resources/${e.resourceId}/download-grants', DownloadGrantModel.fromJson);
}
