// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../data/data_sources/auth/auth_storage_data_source.dart' as _i244;
import '../../../data/data_sources/auth/auth_remote_data_source.dart' as _i401;
import '../../../data/repository/auth/auth_repository.dart' as _i402;
import '../../../domain/repository/auth/i_auth_repository.dart' as _i403;
import '../../../domain/usecase/auth/register_with_email_usecase.dart' as _i404;
import '../../../domain/usecase/i_use_case.dart' as _i405;
import '../../../data/model/auth/auth_model.dart' as _i406;
import '../../../data/model/base/base_model.dart' as _i407;
import '../../../domain/entity/auth/register_with_email_entity.dart' as _i408;
import '../../../domain/entity/auth/register_with_phone_entity.dart' as _i409;
import '../../../domain/usecase/auth/register_with_phone_usecase.dart' as _i410;
import '../../../data/model/auth/verify_email_model.dart' as _i411;
import '../../../domain/entity/auth/verify_email_entity.dart' as _i412;
import '../../../domain/usecase/auth/verify_email_usecase.dart' as _i413;
import '../../../data/model/auth/phone_otp_challenge_model.dart' as _i414;
import '../../../domain/entity/auth/request_phone_otp_entity.dart' as _i415;
import '../../../domain/usecase/auth/request_phone_otp_usecase.dart' as _i416;
import '../../../data/model/auth/phone_otp_verification_model.dart' as _i417;
import '../../../data/model/auth/operation_success_model.dart' as _i418;
import '../../../domain/entity/auth/verify_phone_otp_entity.dart' as _i419;
import '../../../domain/entity/auth/login_with_password_entity.dart' as _i420;
import '../../../domain/entity/auth/request_login_otp_entity.dart' as _i421;
import '../../../domain/entity/auth/login_with_otp_entity.dart' as _i422;
import '../../../domain/entity/auth/request_password_reset_entity.dart' as _i423;
import '../../../domain/entity/auth/reset_password_entity.dart' as _i424;
import '../../../domain/usecase/auth/verify_phone_otp_usecase.dart' as _i425;
import '../../../domain/usecase/auth/login_with_password_usecase.dart' as _i426;
import '../../../domain/usecase/auth/request_login_otp_usecase.dart' as _i427;
import '../../../domain/usecase/auth/login_with_otp_usecase.dart' as _i428;
import '../../../domain/usecase/auth/request_password_reset_usecase.dart' as _i429;
import '../../../domain/usecase/auth/reset_password_usecase.dart' as _i430;
import '../../helper/local_storage_helper.dart' as _i218;
import '../../helper/network_helper.dart' as _i779;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.factory<_i218.LocalStorageHelper>(() => _i218.LocalStorageHelper());
    gh.factory<_i779.NetworkHelper>(() => _i779.NetworkHelper());
    gh.factory<_i244.AuthStorageDataSource>(
      () => _i244.AuthStorageDataSource(),
    );
    gh.factory<_i401.AuthRemoteDataSource>(
      () => _i401.AuthRemoteDataSource(),
    );
    gh.factory<_i403.IAuthRepository>(
      () => _i402.AuthRepository(gh<_i401.AuthRemoteDataSource>()),
    );
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i406.AuthModel>?, _i408.RegisterWithEmailEntity>>(
      () => _i404.RegisterWithEmailUsecase(gh<_i403.IAuthRepository>()),
      instanceName: 'RegisterWithEmail',
    );
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i406.AuthModel>?, _i409.RegisterWithPhoneEntity>>(
      () => _i410.RegisterWithPhoneUsecase(gh<_i403.IAuthRepository>()),
      instanceName: 'RegisterWithPhone',
    );
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i411.VerifyEmailModel>?, _i412.VerifyEmailEntity>>(
      () => _i413.VerifyEmailUsecase(gh<_i403.IAuthRepository>()),
      instanceName: 'VerifyEmail',
    );
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i414.PhoneOtpChallengeModel>?, _i415.RequestPhoneOtpEntity>>(
      () => _i416.RequestPhoneOtpUsecase(gh<_i403.IAuthRepository>()),
      instanceName: 'RequestPhoneOtp',
    );
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i417.PhoneOtpVerificationModel>?, _i419.VerifyPhoneOtpEntity>>(
      () => _i425.VerifyPhoneOtpUsecase(gh<_i403.IAuthRepository>()), instanceName: 'VerifyPhoneOtp');
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i406.AuthModel>?, _i420.LoginWithPasswordEntity>>(
      () => _i426.LoginWithPasswordUsecase(gh<_i403.IAuthRepository>()), instanceName: 'LoginWithPassword');
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i414.PhoneOtpChallengeModel>?, _i421.RequestLoginOtpEntity>>(
      () => _i427.RequestLoginOtpUsecase(gh<_i403.IAuthRepository>()), instanceName: 'RequestLoginOtp');
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i406.AuthModel>?, _i422.LoginWithOtpEntity>>(
      () => _i428.LoginWithOtpUsecase(gh<_i403.IAuthRepository>()), instanceName: 'LoginWithOtp');
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i418.OperationSuccessModel>?, _i423.RequestPasswordResetEntity>>(
      () => _i429.RequestPasswordResetUsecase(gh<_i403.IAuthRepository>()), instanceName: 'RequestPasswordReset');
    gh.factory<_i405.IUseCase<_i407.BaseModel<_i418.OperationSuccessModel>?, _i424.ResetPasswordEntity>>(
      () => _i430.ResetPasswordUsecase(gh<_i403.IAuthRepository>()), instanceName: 'ResetPassword');
    return this;
  }
}
