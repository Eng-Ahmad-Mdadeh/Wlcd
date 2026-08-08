import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_phone_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<AuthModel>?, RegisterWithPhoneEntity>)
@Named('RegisterWithPhone')
class RegisterWithPhoneUsecase
    implements IUseCase<BaseModel<AuthModel>?, RegisterWithPhoneEntity> {
  const RegisterWithPhoneUsecase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<AuthModel>?>> call(
    RegisterWithPhoneEntity data,
  ) {
    return _repository.registerWithPhone(data);
  }
}
