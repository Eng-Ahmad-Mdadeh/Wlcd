import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/instructor/instructor_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/instructor/get_instructor_entity.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';
import 'package:wlcd/domain/repository/instructor/i_instructor_repository.dart';

@Injectable(as: IInstructorRepository)
class InstructorRepository implements IInstructorRepository {
  const InstructorRepository(this._remoteDataSource);

  final InstructorRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<InstructorModel>?>> getInstructors(
    GetInstructorsEntity entity,
  ) => _remoteDataSource.getInstructors(entity);

  @override
  Future<Either<AppException, BaseModel<InstructorModel>?>> getInstructor(
    GetInstructorEntity entity,
  ) => _remoteDataSource.getInstructor(entity);
}
