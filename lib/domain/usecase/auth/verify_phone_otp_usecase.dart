import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/phone_otp_verification_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/verify_phone_otp_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<PhoneOtpVerificationModel>?, VerifyPhoneOtpEntity>)
@Named('VerifyPhoneOtp')
class VerifyPhoneOtpUsecase implements IUseCase<BaseModel<PhoneOtpVerificationModel>?, VerifyPhoneOtpEntity> {
  const VerifyPhoneOtpUsecase(this._repository);
  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<PhoneOtpVerificationModel>?>> call(VerifyPhoneOtpEntity data) {
    return _repository.verifyPhoneOtp(data);
  }
}
