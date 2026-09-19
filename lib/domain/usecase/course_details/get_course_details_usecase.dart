import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/repository/course_details/i_course_details_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<CourseDetailsModel>?, CourseDetailsEntity>)
@Named('GetCourseDetails')
class GetCourseDetailsUsecase implements IUseCase<BaseModel<CourseDetailsModel>?, CourseDetailsEntity> {
  const GetCourseDetailsUsecase(this._repository);

  final ICourseDetailsRepository _repository;

  @override
  Future<Either<AppException, BaseModel<CourseDetailsModel>?>> call(
    CourseDetailsEntity data,
  ) => _repository.getCourseDetails(data);
}
