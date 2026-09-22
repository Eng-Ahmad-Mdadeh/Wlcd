import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/domain/repository/catalog/i_catalog_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<CoursesModel>?, GetCoursesEntity>)
@Named('GetCourses')
class GetCoursesUsecase
    implements IUseCase<BaseModel<CoursesModel>?, GetCoursesEntity> {
  const GetCoursesUsecase(this._repository);

  final ICatalogRepository _repository;

  @override
  Future<Either<AppException, BaseModel<CoursesModel>?>> call(
    GetCoursesEntity data,
  ) => _repository.getCourses(data);
}
