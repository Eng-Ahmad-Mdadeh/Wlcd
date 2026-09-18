import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/repository/course_details/i_course_details_repository.dart';

@injectable
class CourseDetailsUsecase {
  const CourseDetailsUsecase(this.repository);
  final ICourseDetailsRepository repository;
  Future<Either<AppException, BaseModel<T>?>> call<T>(CourseDetailsOperation operation,
      CourseDetailsEntity entity) => repository.execute<T>(operation, entity);
}
