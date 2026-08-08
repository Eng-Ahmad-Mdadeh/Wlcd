import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/phone_otp_challenge_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/request_login_otp_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<PhoneOtpChallengeModel>?, RequestLoginOtpEntity>)
@Named('RequestLoginOtp')
class RequestLoginOtpUsecase implements IUseCase<BaseModel<PhoneOtpChallengeModel>?, RequestLoginOtpEntity> {
  const RequestLoginOtpUsecase(this._repository);
  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<PhoneOtpChallengeModel>?>> call(RequestLoginOtpEntity data) {
    return _repository.requestLoginOtp(data);
  }
}
