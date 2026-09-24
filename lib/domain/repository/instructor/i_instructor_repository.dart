import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/instructor/get_instructor_entity.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';

abstract interface class IInstructorRepository {
  Future<Either<AppException, BaseModel<InstructorModel>?>> getInstructors(
    GetInstructorsEntity entity,
  );

  Future<Either<AppException, BaseModel<InstructorModel>?>> getInstructor(
    GetInstructorEntity entity,
  );
}
