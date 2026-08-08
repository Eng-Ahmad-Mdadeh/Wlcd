import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/auth/auth_remote_data_source.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/auth/verify_email_model.dart';
import 'package:wlcd/data/model/auth/phone_otp_challenge_model.dart';
import 'package:wlcd/data/model/auth/phone_otp_verification_model.dart';
import 'package:wlcd/data/model/auth/operation_success_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';
import 'package:wlcd/domain/entity/auth/register_with_phone_entity.dart';
import 'package:wlcd/domain/entity/auth/verify_email_entity.dart';
import 'package:wlcd/domain/entity/auth/request_phone_otp_entity.dart';
import 'package:wlcd/domain/entity/auth/verify_phone_otp_entity.dart';
import 'package:wlcd/domain/entity/auth/login_with_password_entity.dart';
import 'package:wlcd/domain/entity/auth/request_login_otp_entity.dart';
import 'package:wlcd/domain/entity/auth/login_with_otp_entity.dart';
import 'package:wlcd/domain/entity/auth/request_password_reset_entity.dart';
import 'package:wlcd/domain/entity/auth/reset_password_entity.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';

@Injectable(as: IAuthRepository)
class AuthRepository implements IAuthRepository {
  const AuthRepository(this._remoteDataSource);

  final AuthRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<AuthModel>?>> registerWithEmail(
    RegisterWithEmailEntity data,
  ) {
    return _remoteDataSource.registerWithEmail(data);
  }

  @override
  Future<Either<AppException, BaseModel<AuthModel>?>> registerWithPhone(
    RegisterWithPhoneEntity data,
  ) {
    return _remoteDataSource.registerWithPhone(data);
  }

  @override
  Future<Either<AppException, BaseModel<VerifyEmailModel>?>> verifyEmail(
    VerifyEmailEntity data,
  ) {
    return _remoteDataSource.verifyEmail(data);
  }

  @override
  Future<Either<AppException, BaseModel<PhoneOtpChallengeModel>?>> requestPhoneOtp(
    RequestPhoneOtpEntity data,
  ) {
    return _remoteDataSource.requestPhoneOtp(data);
  }

  @override
  Future<Either<AppException, BaseModel<PhoneOtpVerificationModel>?>> verifyPhoneOtp(
    VerifyPhoneOtpEntity data,
  ) => _remoteDataSource.verifyPhoneOtp(data);
  @override
  Future<Either<AppException, BaseModel<AuthModel>?>> loginWithPassword(
    LoginWithPasswordEntity data,
  ) => _remoteDataSource.loginWithPassword(data);
  @override
  Future<Either<AppException, BaseModel<PhoneOtpChallengeModel>?>> requestLoginOtp(
    RequestLoginOtpEntity data,
  ) => _remoteDataSource.requestLoginOtp(data);
  @override
  Future<Either<AppException, BaseModel<AuthModel>?>> loginWithOtp(
    LoginWithOtpEntity data,
  ) => _remoteDataSource.loginWithOtp(data);
  @override
  Future<Either<AppException, BaseModel<OperationSuccessModel>?>> requestPasswordReset(
    RequestPasswordResetEntity data,
  ) => _remoteDataSource.requestPasswordReset(data);
  @override
  Future<Either<AppException, BaseModel<OperationSuccessModel>?>> resetPassword(
    ResetPasswordEntity data,
  ) => _remoteDataSource.resetPassword(data);
}
