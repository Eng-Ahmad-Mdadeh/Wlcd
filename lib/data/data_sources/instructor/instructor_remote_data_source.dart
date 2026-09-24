import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/instructor/get_instructor_entity.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';

@injectable
class InstructorRemoteDataSource extends BaseRemoteDataSource<Object> {
  InstructorRemoteDataSource() : super('');

  Future<Either<AppException, BaseModel<InstructorModel>?>> getInstructors(GetInstructorsEntity entity) =>
      fetchDataAs<InstructorModel>(
        endpoint: ApiEndpoints.instructors,
        queryParams: entity.toQueryParameters(),
        fromJsonT: (json) => InstructorModel.fromJson(json as Map<String, dynamic>),
        wrappedResponse: false,
      );

  Future<Either<AppException, BaseModel<InstructorModel>?>> getInstructor(GetInstructorEntity entity) =>
      fetchDataAs<InstructorModel>(
        endpoint: ApiEndpoints.instructor(entity.instructorId),
        fromJsonT: (json) => InstructorModel.fromJson(json as Map<String, dynamic>),
        wrappedResponse: false,
      );
}
