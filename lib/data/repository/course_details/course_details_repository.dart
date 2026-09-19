import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/course_details/course_details_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/repository/course_details/i_course_details_repository.dart';

@Injectable(as: ICourseDetailsRepository)
class CourseDetailsRepository implements ICourseDetailsRepository {
  const CourseDetailsRepository(this.remote);
  final CourseDetailsRemoteDataSource remote;

  @override
  Future<Either<AppException, BaseModel<T>?>> execute<T>(CourseDetailsOperation operation,
      CourseDetailsEntity entity) async {
    final result = await switch (operation) {
      CourseDetailsOperation.courseDetails => remote.getCourseDetails(entity),
      CourseDetailsOperation.ratingSummary => remote.getRatingSummary(entity),
      CourseDetailsOperation.reviews => remote.listReviews(entity),
      CourseDetailsOperation.enrollment => remote.getEnrollment(entity),
      CourseDetailsOperation.accessStatus => remote.getAccessStatus(entity),
      CourseDetailsOperation.enrollFree => remote.enrollFree(entity),
      CourseDetailsOperation.checkoutQuote => remote.getCheckoutQuote(entity),
      CourseDetailsOperation.favoriteStatus => remote.isFavorited(entity),
      CourseDetailsOperation.learningState => remote.getLearningState(entity),
      CourseDetailsOperation.curriculum => remote.getCurriculum(entity),
      CourseDetailsOperation.lesson => remote.getLesson(entity),
      CourseDetailsOperation.playback => remote.resolvePlayback(entity),
      CourseDetailsOperation.lessonProgress => remote.getLessonProgress(entity),
      CourseDetailsOperation.startLearning => remote.startLearning(entity),
      CourseDetailsOperation.recordProgress => remote.recordProgress(entity),
      CourseDetailsOperation.completeLesson => remote.completeLesson(entity),
      CourseDetailsOperation.updateResume => remote.updateResume(entity),
      CourseDetailsOperation.courseCompletion => remote.getCompletion(entity),
      CourseDetailsOperation.resources => remote.listResources(entity),
      CourseDetailsOperation.downloadGrant => remote.createDownloadGrant(entity),
    };
    return result.fold(Left.new, (value) => Right(value as BaseModel<T>?));
  }
}
