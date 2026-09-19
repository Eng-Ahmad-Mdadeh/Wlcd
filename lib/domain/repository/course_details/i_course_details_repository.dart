import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';

abstract interface class ICourseDetailsRepository {
  Future<Either<AppException, BaseModel<CourseDetailsModel>?>> getCourseDetails(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getRatingSummary(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> listReviews(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<EnrollmentModel>?>> getEnrollment(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getAccessStatus(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<EnrollmentModel>?>> enrollFree(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getCheckoutQuote(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> isFavorited(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<LearningStateModel>?>> getLearningState(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<CurriculumModel>?>> getCurriculum(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<LessonModel>?>> getLesson(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<PlaybackModel>?>> resolvePlayback(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getLessonProgress(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> startLearning(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ProgressEventModel>?>> recordProgress(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> completeLesson(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ResumePositionModel>?>> updateResume(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> getCompletion(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<ContractJsonModel>?>> listResources(
    CourseDetailsEntity entity,
  );

  Future<Either<AppException, BaseModel<DownloadGrantModel>?>> createDownloadGrant(
    CourseDetailsEntity entity,
  );

}
