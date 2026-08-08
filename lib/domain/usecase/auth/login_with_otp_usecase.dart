import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/login_with_otp_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<AuthModel>?, LoginWithOtpEntity>)
@Named('LoginWithOtp')
class LoginWithOtpUsecase implements IUseCase<BaseModel<AuthModel>?, LoginWithOtpEntity> {
  const LoginWithOtpUsecase(this._repository);
  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<AuthModel>?>> call(LoginWithOtpEntity data) {
    return _repository.loginWithOtp(data);
  }
}
