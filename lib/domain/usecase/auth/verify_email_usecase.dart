import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/verify_email_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/verify_email_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<VerifyEmailModel>?, VerifyEmailEntity>)
@Named('VerifyEmail')
class VerifyEmailUsecase
    implements IUseCase<BaseModel<VerifyEmailModel>?, VerifyEmailEntity> {
  const VerifyEmailUsecase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<VerifyEmailModel>?>> call(
    VerifyEmailEntity data,
  ) {
    return _repository.verifyEmail(data);
  }
}
