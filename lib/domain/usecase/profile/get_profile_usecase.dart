import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile/profile_model.dart';
import 'package:wlcd/domain/repository/profile/i_profile_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<ProfileModel>?, Null>)
@Named('GetProfile')
class GetProfileUsecase implements IUseCase<BaseModel<ProfileModel>?, Null> {
  const GetProfileUsecase(this._repository);
  final IProfileRepository _repository;

  @override
  Future<Either<AppException, BaseModel<ProfileModel>?>> call(Null data) =>
      _repository.getProfile();
}
