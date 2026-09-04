import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/domain/entity/catalog/get_featured_courses_entity.dart';
import 'package:wlcd/domain/repository/catalog/i_catalog_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(
  as: IUseCase<BaseModel<CoursesModel>?, GetFeaturedCoursesEntity>,
)
@Named('GetFeaturedCourses')
class GetFeaturedCoursesUsecase
    implements IUseCase<BaseModel<CoursesModel>?, GetFeaturedCoursesEntity> {
  const GetFeaturedCoursesUsecase(this._repository);

  final ICatalogRepository _repository;

  @override
  Future<Either<AppException, BaseModel<CoursesModel>?>> call(
    GetFeaturedCoursesEntity data,
  ) => _repository.getFeaturedCourses(data);
}
