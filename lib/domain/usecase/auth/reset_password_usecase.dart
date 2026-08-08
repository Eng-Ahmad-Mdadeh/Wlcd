import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/operation_success_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/reset_password_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<OperationSuccessModel>?, ResetPasswordEntity>)
@Named('ResetPassword')
class ResetPasswordUsecase implements IUseCase<BaseModel<OperationSuccessModel>?, ResetPasswordEntity> {
  const ResetPasswordUsecase(this._repository);
  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<OperationSuccessModel>?>> call(ResetPasswordEntity data) {
    return _repository.resetPassword(data);
  }
}
