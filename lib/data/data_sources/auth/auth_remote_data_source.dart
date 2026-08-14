import 'package:wlcd/domain/entity/auth/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/auth/verify_email_model.dart';
import 'package:wlcd/data/model/auth/phone_otp_challenge_model.dart';
import 'package:wlcd/data/model/auth/phone_otp_verification_model.dart';
import 'package:wlcd/data/model/auth/operation_success_model.dart';
import 'package:wlcd/data/model/auth/session_model.dart';
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

@Injectable()
class AuthRemoteDataSource extends BaseRemoteDataSource<AuthModel> {
  AuthRemoteDataSource() : super(ApiEndpoints.auth);

  Future<Either<AppException, BaseModel<AuthModel>?>> registerWithEmail(RegisterWithEmailEntity data) {
    return postData(
      endpoint: ApiEndpoints.registerWithEmail,
      fromJsonT: (json) => AuthModel.fromJson(json as Map<String, dynamic>),
      data: data.toJson(),
      headers: data.headers,
      isFormDate: false,
      wrappedResponse: false,
      includeAuthorization: false,
    );
  }

  Future<Either<AppException, BaseModel<AuthModel>?>> registerWithPhone(RegisterWithPhoneEntity data) {
    return postData(
      endpoint: ApiEndpoints.registerWithPhone,
      fromJsonT: (json) => AuthModel.fromJson(json as Map<String, dynamic>),
      data: data.toJson(),
      headers: data.headers,
      isFormDate: false,
      wrappedResponse: false,
      includeAuthorization: false,
    );
  }

  Future<Either<AppException, BaseModel<VerifyEmailModel>?>> verifyEmail(VerifyEmailEntity data) {
    return postDataAs<VerifyEmailModel>(
      endpoint: ApiEndpoints.verifyEmail,
      fromJsonT: (json) => VerifyEmailModel.fromJson(json as Map<String, dynamic>),
      data: data.toJson(),
      isFormDate: false,
      wrappedResponse: false,
      includeAuthorization: false,
    );
  }

  Future<Either<AppException, BaseModel<PhoneOtpChallengeModel>?>> requestPhoneOtp(RequestPhoneOtpEntity data) {
    return postDataAs<PhoneOtpChallengeModel>(
      endpoint: ApiEndpoints.requestPhoneOtp,
      fromJsonT: (json) => PhoneOtpChallengeModel.fromJson(json as Map<String, dynamic>),
      data: data.toJson(),
      isFormDate: false,
      wrappedResponse: false,
      includeAuthorization: false,
    );
  }

  Future<Either<AppException, BaseModel<PhoneOtpVerificationModel>?>> verifyPhoneOtp(VerifyPhoneOtpEntity data) =>
      postDataAs(
        endpoint: ApiEndpoints.verifyPhoneOtp,
        fromJsonT: (json) => PhoneOtpVerificationModel.fromJson(json as Map<String, dynamic>),
        data: data.toJson(),
        isFormDate: false,
        wrappedResponse: false,
        includeAuthorization: false,
      );

  Future<Either<AppException, BaseModel<AuthModel>?>> loginWithPassword(LoginWithPasswordEntity data) => postData(
    endpoint: ApiEndpoints.loginWithPassword,
    fromJsonT: (json) => AuthModel.fromJson(json as Map<String, dynamic>),
    data: data.toJson(),
    headers: data.headers,
    isFormDate: false,
    wrappedResponse: false,
    includeAuthorization: false,
  );

  Future<Either<AppException, BaseModel<PhoneOtpChallengeModel>?>> requestLoginOtp(RequestLoginOtpEntity data) =>
      postDataAs(
        endpoint: ApiEndpoints.requestLoginOtp,
        fromJsonT: (json) => PhoneOtpChallengeModel.fromJson(json as Map<String, dynamic>),
        data: data.toJson(),
        isFormDate: false,
        wrappedResponse: false,
        includeAuthorization: false,
      );

  Future<Either<AppException, BaseModel<AuthModel>?>> loginWithOtp(LoginWithOtpEntity data) => postData(
    endpoint: ApiEndpoints.loginWithOtp,
    fromJsonT: (json) => AuthModel.fromJson(json as Map<String, dynamic>),
    data: data.toJson(),
    headers: data.headers,
    isFormDate: false,
    wrappedResponse: false,
    includeAuthorization: false,
  );

  Future<Either<AppException, BaseModel<OperationSuccessModel>?>> requestPasswordReset(
    RequestPasswordResetEntity data,
  ) => postDataAs(
    endpoint: ApiEndpoints.requestPasswordReset,
    fromJsonT: (json) => OperationSuccessModel.fromJson(json as Map<String, dynamic>),
    data: data.toJson(),
    isFormDate: false,
    wrappedResponse: false,
    includeAuthorization: false,
  );

  Future<Either<AppException, BaseModel<OperationSuccessModel>?>> resetPassword(ResetPasswordEntity data) => postDataAs(
    endpoint: ApiEndpoints.resetPassword,
    fromJsonT: (json) => OperationSuccessModel.fromJson(json as Map<String, dynamic>),
    data: data.toJson(),
    headers: data.headers,
    isFormDate: false,
    wrappedResponse: false,
    includeAuthorization: false,
  );

  Future<Either<AppException, BaseModel<OperationSuccessModel>?>> logout() => postDataAs(
    endpoint: ApiEndpoints.logout,
    fromJsonT: (json) => OperationSuccessModel.fromJson(json as Map<String, dynamic>),
    isFormDate: false,
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<SessionModel>?>> getSession() => fetchDataAs(
    endpoint: ApiEndpoints.session,
    fromJsonT: (json) => SessionModel.fromJson(json as Map<String, dynamic>),
    wrappedResponse: false,
  );

  Future<Either<AppException, BaseModel<AuthModel>?>> login(AuthEntity data) {
    return postData(
      endpoint: ApiEndpoints.login,
      fromJsonT: (json) => AuthModel.fromJson(json as Map<String, dynamic>),
      data: data.toJson(),
    );
  }

  Future<Either<AppException, BaseModel<AuthModel>?>> checkCode(AuthEntity data) {
    return postData(
      endpoint: ApiEndpoints.checkCode,
      fromJsonT: (json) => AuthModel.fromJson(json as Map<String, dynamic>),
      data: data.toJson(),
    );
  }

  Future<Either<AppException, BaseModel<AuthModel>?>> resendCode(AuthEntity data) {
    return postData(
      endpoint: ApiEndpoints.login,
      // fromJsonT: (json) => AuthModel.fromJson(json as Map<String, dynamic>),
      data: data.toJson(),
    );
  }

  // Future<Either<AppException, AuthModel>> logout() {
  //   throw UnimplementedError('This function is not exist in remote use local instead');
  // }
}
