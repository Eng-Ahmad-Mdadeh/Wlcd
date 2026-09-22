import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';

@injectable
class CoursesRemoteDataSource extends BaseRemoteDataSource<Object> {
  CoursesRemoteDataSource() : super('');

  Future<Either<AppException, BaseModel<CoursesModel>?>> getCourses(
    GetCoursesEntity entity,
  ) => fetchDataAs<CoursesModel>(
    endpoint: ApiEndpoints.courses,
    queryParams: entity.toQueryParameters(),
    fromJsonT: (json) => CoursesModel.fromJson(json as Map<String, dynamic>),
    wrappedResponse: false,
  );
}
