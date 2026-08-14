import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/complete_profile_entity.dart';
import 'package:wlcd/domain/repository/profile/i_profile_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<ProfileModel>?, CompleteProfileEntity>)
@Named('CompleteProfile')
class CompleteProfileUsecase
    implements IUseCase<BaseModel<ProfileModel>?, CompleteProfileEntity> {
  const CompleteProfileUsecase(this._repository);
  final IProfileRepository _repository;

  @override
  Future<Either<AppException, BaseModel<ProfileModel>?>> call(
    CompleteProfileEntity data,
  ) => _repository.completeProfile(data);
}
