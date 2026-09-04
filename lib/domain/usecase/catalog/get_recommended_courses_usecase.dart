import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/course/courses_model.dart';
import 'package:wlcd/domain/repository/catalog/i_catalog_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<CoursesModel>?, Null>)
@Named('GetRecommendedCourses')
class GetRecommendedCoursesUsecase
    implements IUseCase<BaseModel<CoursesModel>?, Null> {
  const GetRecommendedCoursesUsecase(this._repository);

  final ICatalogRepository _repository;

  @override
  Future<Either<AppException, BaseModel<CoursesModel>?>> call(Null data) =>
      _repository.getRecommendedCourses();
}
