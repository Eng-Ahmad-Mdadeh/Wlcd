import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/instructor/instructor_model.dart';
import 'package:wlcd/domain/entity/instructor/get_instructors_entity.dart';
import 'package:wlcd/domain/repository/instructor/i_instructor_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<InstructorModel>?, GetInstructorsEntity>)
@Named('GetInstructors')
class GetInstructorsUsecase
    implements IUseCase<BaseModel<InstructorModel>?, GetInstructorsEntity> {
  const GetInstructorsUsecase(this._repository);

  final IInstructorRepository _repository;

  @override
  Future<Either<AppException, BaseModel<InstructorModel>?>> call(
    GetInstructorsEntity data,
  ) => _repository.getInstructors(data);
}
