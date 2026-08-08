import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/phone_otp_challenge_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/request_phone_otp_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(
  as: IUseCase<BaseModel<PhoneOtpChallengeModel>?, RequestPhoneOtpEntity>,
)
@Named('RequestPhoneOtp')
class RequestPhoneOtpUsecase
    implements
        IUseCase<BaseModel<PhoneOtpChallengeModel>?, RequestPhoneOtpEntity> {
  const RequestPhoneOtpUsecase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<PhoneOtpChallengeModel>?>> call(
    RequestPhoneOtpEntity data,
  ) {
    return _repository.requestPhoneOtp(data);
  }
}
