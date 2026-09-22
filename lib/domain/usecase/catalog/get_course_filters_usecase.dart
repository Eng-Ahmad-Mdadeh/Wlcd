import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/domain/repository/catalog/i_catalog_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<CourseFiltersModel>?, Null>)
@Named('GetCourseFilters')
class GetCourseFiltersUsecase implements IUseCase<BaseModel<CourseFiltersModel>?, Null> {
  const GetCourseFiltersUsecase(this._repository);

  final ICatalogRepository _repository;

  @override
  Future<Either<AppException, BaseModel<CourseFiltersModel>?>> call(Null data) =>
      _repository.getCourseFilters();
}
