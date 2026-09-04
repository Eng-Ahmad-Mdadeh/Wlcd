// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../../data/data_sources/auth/auth_remote_data_source.dart' as _i444;
import '../../../data/data_sources/auth/auth_storage_data_source.dart' as _i244;
import '../../../data/data_sources/catalog/catalog_remote_data_source.dart'
    as _i1001;
import '../../../data/data_sources/profile/profile_remote_data_source.dart'
    as _i265;
import '../../../data/model/auth/auth_model.dart' as _i49;
import '../../../data/model/auth/operation_success_model.dart' as _i938;
import '../../../data/model/auth/phone_otp_challenge_model.dart' as _i959;
import '../../../data/model/auth/phone_otp_verification_model.dart' as _i248;
import '../../../data/model/auth/session_model.dart' as _i695;
import '../../../data/model/auth/verify_email_model.dart' as _i638;
import '../../../data/model/base/base_model.dart' as _i830;
import '../../../data/model/catalog/categories/categories_model.dart' as _i1002;
import '../../../data/model/catalog/course/courses_model.dart' as _i1003;
import '../../../data/model/profile/email_identifier_model.dart' as _i737;
import '../../../data/model/profile/phone_identifier_model.dart' as _i994;
import '../../../data/model/profile/profile_model.dart' as _i967;
import '../../../data/repository/auth/auth_repository.dart' as _i728;
import '../../../data/repository/catalog/catalog_repository.dart' as _i1004;
import '../../../data/repository/profile/profile_repository.dart' as _i732;
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
import '../../../domain/entity/catalog/get_featured_courses_entity.dart'
    as _i1005;
import '../../../domain/entity/profile/add_email_identifier_entity.dart'
    as _i202;
import '../../../domain/entity/profile/add_phone_identifier_entity.dart'
    as _i828;
import '../../../domain/entity/profile/change_email_entity.dart' as _i614;
import '../../../domain/entity/profile/change_phone_entity.dart' as _i212;
import '../../../domain/entity/profile/complete_profile_entity.dart' as _i904;
import '../../../domain/entity/profile/update_profile_entity.dart' as _i233;
import '../../../domain/entity/profile/upload_avatar_entity.dart' as _i82;
import '../../../domain/repository/auth/i_auth_repository.dart' as _i154;
import '../../../domain/repository/catalog/i_catalog_repository.dart' as _i1006;
import '../../../domain/repository/profile/i_profile_repository.dart' as _i950;
import '../../../domain/usecase/auth/get_session_usecase.dart' as _i410;
import '../../../domain/usecase/auth/login_with_otp_usecase.dart' as _i446;
import '../../../domain/usecase/auth/login_with_password_usecase.dart' as _i823;
import '../../../domain/usecase/auth/logout_usecase.dart' as _i659;
import '../../../domain/usecase/auth/register_with_email_usecase.dart' as _i714;
import '../../../domain/usecase/auth/register_with_phone_usecase.dart' as _i14;
import '../../../domain/usecase/auth/request_login_otp_usecase.dart' as _i804;
import '../../../domain/usecase/auth/request_password_reset_usecase.dart'
    as _i65;
import '../../../domain/usecase/auth/request_phone_otp_usecase.dart' as _i784;
import '../../../domain/usecase/auth/reset_password_usecase.dart' as _i888;
import '../../../domain/usecase/auth/verify_email_usecase.dart' as _i46;
import '../../../domain/usecase/auth/verify_phone_otp_usecase.dart' as _i827;
import '../../../domain/usecase/catalog/get_featured_courses_usecase.dart'
    as _i1007;
import '../../../domain/usecase/catalog/get_recommended_courses_usecase.dart'
    as _i1008;
import '../../../domain/usecase/catalog/list_categories_usecase.dart' as _i1009;
import '../../../domain/usecase/i_use_case.dart' as _i759;
import '../../../domain/usecase/profile/add_email_identifier_usecase.dart'
    as _i726;
import '../../../domain/usecase/profile/add_phone_identifier_usecase.dart'
    as _i469;
import '../../../domain/usecase/profile/change_email_usecase.dart' as _i374;
import '../../../domain/usecase/profile/change_phone_usecase.dart' as _i230;
import '../../../domain/usecase/profile/complete_profile_usecase.dart' as _i373;
import '../../../domain/usecase/profile/get_profile_usecase.dart' as _i406;
import '../../../domain/usecase/profile/update_profile_usecase.dart' as _i999;
import '../../../domain/usecase/profile/upload_avatar_usecase.dart' as _i911;
import '../../helper/network_helper.dart' as _i779;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.factory<_i779.NetworkHelper>(() => _i779.NetworkHelper());
    gh.factory<_i444.AuthRemoteDataSource>(() => _i444.AuthRemoteDataSource());
    gh.factory<_i1001.CatalogRemoteDataSource>(
      () => _i1001.CatalogRemoteDataSource(),
    );
    gh.factory<_i265.ProfileRemoteDataSource>(
      () => _i265.ProfileRemoteDataSource(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.factory<_i244.AuthStorageDataSource>(
      () => _i244.AuthStorageDataSource(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i950.IProfileRepository>(
      () => _i732.ProfileRepository(gh<_i265.ProfileRemoteDataSource>()),
    );
    gh.factory<_i1006.ICatalogRepository>(
      () => _i1004.CatalogRepository(gh<_i1001.CatalogRemoteDataSource>()),
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i1002.CategoriesModel>?, Null>
    >(
      () => _i1009.ListCategoriesUsecase(gh<_i1006.ICatalogRepository>()),
      instanceName: 'ListCategories',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i1003.CoursesModel>?,
        _i1005.GetFeaturedCoursesEntity
      >
    >(
      () => _i1007.GetFeaturedCoursesUsecase(
        gh<_i1006.ICatalogRepository>(),
      ),
      instanceName: 'GetFeaturedCourses',
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i1003.CoursesModel>?, Null>
    >(
      () => _i1008.GetRecommendedCoursesUsecase(
        gh<_i1006.ICatalogRepository>(),
      ),
      instanceName: 'GetRecommendedCourses',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i967.ProfileModel>?,
        _i82.UploadAvatarEntity
      >
    >(
      () => _i911.UploadAvatarUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'UploadAvatar',
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
        _i830.BaseModel<_i994.PhoneIdentifierModel>?,
        _i828.AddPhoneIdentifierEntity
      >
    >(
      () => _i469.AddPhoneIdentifierUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'AddPhoneIdentifier',
    );
    gh.factory<_i154.IAuthRepository>(
      () => _i728.AuthRepository(
        gh<_i444.AuthRemoteDataSource>(),
        gh<_i244.AuthStorageDataSource>(),
      ),
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i994.PhoneIdentifierModel>?,
        _i212.ChangePhoneEntity
      >
    >(
      () => _i230.ChangePhoneUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'ChangePhone',
    );
    gh.factory<_i759.IUseCase<_i830.BaseModel<_i967.ProfileModel>?, Null>>(
      () => _i406.GetProfileUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'GetProfile',
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i938.OperationSuccessModel>?, Null>
    >(
      () => _i659.LogoutUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'Logout',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i737.EmailIdentifierModel>?,
        _i202.AddEmailIdentifierEntity
      >
    >(
      () => _i726.AddEmailIdentifierUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'AddEmailIdentifier',
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
        _i830.BaseModel<_i967.ProfileModel>?,
        _i904.CompleteProfileEntity
      >
    >(
      () => _i373.CompleteProfileUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'CompleteProfile',
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
        _i830.BaseModel<_i967.ProfileModel>?,
        _i233.UpdateProfileEntity
      >
    >(
      () => _i999.UpdateProfileUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'UpdateProfile',
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
        _i830.BaseModel<_i737.EmailIdentifierModel>?,
        _i614.ChangeEmailEntity
      >
    >(
      () => _i374.ChangeEmailUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'ChangeEmail',
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
    gh.factory<_i759.IUseCase<_i830.BaseModel<_i695.SessionModel>?, Null>>(
      () => _i410.GetSessionUsecase(gh<_i154.IAuthRepository>()),
      instanceName: 'GetSession',
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

class _$RegisterModule extends _i291.RegisterModule {}
