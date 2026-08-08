import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/operation_success_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/request_password_reset_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<OperationSuccessModel>?, RequestPasswordResetEntity>)
@Named('RequestPasswordReset')
class RequestPasswordResetUsecase implements IUseCase<BaseModel<OperationSuccessModel>?, RequestPasswordResetEntity> {
  const RequestPasswordResetUsecase(this._repository);
  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<OperationSuccessModel>?>> call(RequestPasswordResetEntity data) {
    return _repository.requestPasswordReset(data);
  }
}
