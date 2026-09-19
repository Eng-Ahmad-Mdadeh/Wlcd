import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/course_details/course_details_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/repository/course_details/i_course_details_repository.dart';

@Injectable(as: ICourseDetailsRepository)
class CourseDetailsRepository implements ICourseDetailsRepository {
  const CourseDetailsRepository(this._remoteDataSource);

  final CourseDetailsRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<CourseDetailsModel>?>> getCourseDetails(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getCourseDetails(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getRatingSummary(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getRatingSummary(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> listReviews(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.listReviews(entity);

  @override
  Future<Either<AppException, BaseModel<EnrollmentModel>?>> getEnrollment(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getEnrollment(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getAccessStatus(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getAccessStatus(entity);

  @override
  Future<Either<AppException, BaseModel<EnrollmentModel>?>> enrollFree(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.enrollFree(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getCheckoutQuote(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getCheckoutQuote(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> isFavorited(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.isFavorited(entity);

  @override
  Future<Either<AppException, BaseModel<LearningStateModel>?>> getLearningState(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getLearningState(entity);

  @override
  Future<Either<AppException, BaseModel<CurriculumModel>?>> getCurriculum(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getCurriculum(entity);

  @override
  Future<Either<AppException, BaseModel<LessonModel>?>> getLesson(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getLesson(entity);

  @override
  Future<Either<AppException, BaseModel<PlaybackModel>?>> resolvePlayback(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.resolvePlayback(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getLessonProgress(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getLessonProgress(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> startLearning(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.startLearning(entity);

  @override
  Future<Either<AppException, BaseModel<ProgressEventModel>?>> recordProgress(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.recordProgress(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> completeLesson(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.completeLesson(entity);

  @override
  Future<Either<AppException, BaseModel<ResumePositionModel>?>> updateResume(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.updateResume(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getCompletion(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.getCompletion(entity);

  @override
  Future<Either<AppException, BaseModel<ContractJsonModel>?>> listResources(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.listResources(entity);

  @override
  Future<Either<AppException, BaseModel<DownloadGrantModel>?>> createDownloadGrant(
    CourseDetailsEntity entity,
  ) => _remoteDataSource.createDownloadGrant(entity);

}
