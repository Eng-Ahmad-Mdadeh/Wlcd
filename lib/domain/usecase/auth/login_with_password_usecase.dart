import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/login_with_password_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<AuthModel>?, LoginWithPasswordEntity>)
@Named('LoginWithPassword')
class LoginWithPasswordUsecase implements IUseCase<BaseModel<AuthModel>?, LoginWithPasswordEntity> {
  const LoginWithPasswordUsecase(this._repository);
  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<AuthModel>?>> call(LoginWithPasswordEntity data) {
    return _repository.loginWithPassword(data);
  }
}
