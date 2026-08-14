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
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i777;

import '../../../data/data_sources/auth/auth_storage_data_source.dart' as _i778;
import '../../../data/data_sources/auth/auth_remote_data_source.dart' as _i444;
import '../../../data/model/auth/auth_model.dart' as _i49;
import '../../../data/model/auth/operation_success_model.dart' as _i938;
import '../../../data/model/auth/session_model.dart' as _i939;
import '../../../data/model/auth/phone_otp_challenge_model.dart' as _i959;
import '../../../data/model/auth/phone_otp_verification_model.dart' as _i248;
import '../../../data/model/auth/verify_email_model.dart' as _i638;
import '../../../data/model/base/base_model.dart' as _i830;
import '../../../data/repository/auth/auth_repository.dart' as _i728;
import '../../../domain/entity/auth/auth_entity.dart' as _i250;
import '../../../domain/entity/auth/login_with_otp_entity.dart' as _i352;
import '../../../domain/entity/auth/login_with_password_entity.dart' as _i679;
import '../../../domain/entity/auth/register_with_email_entity.dart' as _i207;
import '../../../domain/entity/auth/register_with_phone_entity.dart' as _i1034;
import '../../../domain/entity/auth/request_login_otp_entity.dart' as _i745;
import '../../../domain/entity/auth/request_password_reset_entity.dart'
    as _i552;
import '../../../domain/entity/auth/request_phone_otp_entity.dart' as _i92;
import '../../../domain/entity/auth/reset_password_entity.dart' as _i394;
import '../../../domain/entity/auth/verify_email_entity.dart' as _i853;
import '../../../domain/entity/auth/verify_phone_otp_entity.dart' as _i982;
import '../../../domain/repository/auth/i_auth_repository.dart' as _i154;
import '../../../domain/usecase/auth/get_session_usecase.dart' as _i900;
import '../../../domain/usecase/auth/logout_usecase.dart' as _i901;
import '../../../domain/usecase/auth/login_with_otp_usecase.dart' as _i446;
import '../../../domain/usecase/auth/login_with_password_usecase.dart' as _i823;
import '../../../domain/usecase/auth/register_with_email_usecase.dart' as _i714;
import '../../../domain/usecase/auth/register_with_phone_usecase.dart' as _i14;
import '../../../domain/usecase/auth/request_login_otp_usecase.dart' as _i804;
import '../../../domain/usecase/auth/request_password_reset_usecase.dart'
    as _i65;
import '../../../domain/usecase/auth/request_phone_otp_usecase.dart' as _i784;
import '../../../domain/usecase/auth/reset_password_usecase.dart' as _i888;
import '../../../domain/usecase/auth/verify_email_usecase.dart' as _i46;
import '../../../domain/usecase/auth/verify_phone_otp_usecase.dart' as _i827;
import '../../../domain/usecase/i_use_case.dart' as _i759;
import '../../helper/network_helper.dart' as _i779;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    gh.lazySingleton<_i777.FlutterSecureStorage>(() => const _i777.FlutterSecureStorage());
    gh.factory<_i778.AuthStorageDataSource>(() => _i778.AuthStorageDataSource(gh<_i777.FlutterSecureStorage>()));
    gh.factory<_i779.NetworkHelper>(() => _i779.NetworkHelper());
    gh.factory<_i444.AuthRemoteDataSource>(() => _i444.AuthRemoteDataSource());
    gh.factory<_i154.IAuthRepository>(
      () => _i728.AuthRepository(gh<_i444.AuthRemoteDataSource>(), gh<_i778.AuthStorageDataSource>()),
    );

    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i939.SessionModel>?, Null>
    >(
      () => _i900.GetSessionUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'GetSession',
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i938.OperationSuccessModel>?, Null>
    >(
      () => _i901.LogoutUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'Logout',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i248.PhoneOtpVerificationModel>?,
        _i982.VerifyPhoneOtpEntity
      >
    >(
      () => _i827.VerifyPhoneOtpUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'VerifyPhoneOtp',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i49.AuthModel>?,
        _i1034.RegisterWithPhoneEntity
      >
    >(
      () => _i14.RegisterWithPhoneUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'RegisterWithPhone',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i638.VerifyEmailModel>?,
        _i853.VerifyEmailEntity
      >
    >(
      () => _i46.VerifyEmailUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'VerifyEmail',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i49.AuthModel>?,
        _i679.LoginWithPasswordEntity
      >
    >(
      () => _i823.LoginWithPasswordUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'LoginWithPassword',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i938.OperationSuccessModel>?,
        _i394.ResetPasswordEntity
      >
    >(
      () => _i888.ResetPasswordUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'ResetPassword',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i49.AuthModel>?,
        _i207.RegisterWithEmailEntity
      >
    >(
      () => _i714.RegisterWithEmailUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'RegisterWithEmail',
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i49.AuthModel>?, _i352.LoginWithOtpEntity>
    >(
      () => _i446.LoginWithOtpUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'LoginWithOtp',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i959.PhoneOtpChallengeModel>?,
        _i92.RequestPhoneOtpEntity
      >
    >(
      () => _i784.RequestPhoneOtpUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'RequestPhoneOtp',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i938.OperationSuccessModel>?,
        _i552.RequestPasswordResetEntity
      >
    >(
      () => _i65.RequestPasswordResetUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'RequestPasswordReset',
    );
    gh.factory<_i250.AuthEntity>(
      () => _i250.AuthEntity(
        phone: gh<String>(),
        typeMessage: gh<String>(),
        code: gh<String>(),
        fcm: gh<String>(),
        rememberMe: gh<bool>(),
      ),
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i959.PhoneOtpChallengeModel>?,
        _i745.RequestLoginOtpEntity
      >
    >(
      () => _i804.RequestLoginOtpUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'RequestLoginOtp',
    );
    return this;
  }
}
