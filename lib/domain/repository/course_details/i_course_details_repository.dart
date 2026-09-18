import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';

abstract interface class ICourseDetailsRepository {
  Future<Either<AppException, BaseModel<T>?>> execute<T>(CourseDetailsOperation operation,
      CourseDetailsEntity entity);
}

enum CourseDetailsOperation { courseDetails, ratingSummary, reviews, enrollment, accessStatus,
  enrollFree, checkoutQuote, favoriteStatus, learningState, curriculum, lesson, playback,
  lessonProgress, startLearning, recordProgress, completeLesson, updateResume, courseCompletion,
  resources, downloadGrant }
