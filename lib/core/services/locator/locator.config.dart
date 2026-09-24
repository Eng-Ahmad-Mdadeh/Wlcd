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
    as _i344;
import '../../../data/data_sources/course_details/course_details_remote_data_source.dart'
    as _i647;
import '../../../data/data_sources/favorites/favorites_remote_data_source.dart'
    as _i492;
import '../../../data/data_sources/instructor/instructor_remote_data_source.dart'
    as _i1201;
import '../../../data/data_sources/notifications/notifications_remote_data_source.dart'
    as _i334;
import '../../../data/data_sources/profile/profile_remote_data_source.dart'
    as _i265;
import '../../../data/model/auth/auth_model.dart' as _i49;
import '../../../data/model/auth/operation_success_model.dart' as _i938;
import '../../../data/model/auth/phone_otp_challenge_model.dart' as _i959;
import '../../../data/model/auth/phone_otp_verification_model.dart' as _i248;
import '../../../data/model/auth/session_model.dart' as _i695;
import '../../../data/model/auth/verify_email_model.dart' as _i638;
import '../../../data/model/base/base_model.dart' as _i830;
import '../../../data/model/catalog/categories/categories_model.dart' as _i621;
import '../../../data/model/catalog/banners/banners_model.dart' as _i1100;
import '../../../data/model/catalog/course_filters/course_filters_model.dart' as _i1101;
import '../../../data/model/catalog/global_platforms/global_platforms_model.dart' as _i1102;
import '../../../data/model/catalog/courses/courses_model.dart' as _i102;
import '../../../data/model/catalog/recommendations/recommendations_model.dart'
    as _i874;
import '../../../data/model/course_details/course_details_model.dart' as _i102;
import '../../../data/model/favorites/favorite_group_model.dart' as _i388;
import '../../../data/model/favorites/favorite_groups_model.dart' as _i214;
import '../../../data/model/favorites/favorite_membership_model.dart' as _i955;
import '../../../data/model/favorites/favorite_memberships_model.dart' as _i939;
import '../../../data/model/instructor/instructor_model.dart' as _i1202;
import '../../../data/model/notifications/notification/notification_model.dart'
    as _i758;
import '../../../data/model/notifications/notification_preferences/notification_preferences_model.dart'
    as _i341;
import '../../../data/model/notifications/unread_notification_count/unread_notification_count_model.dart'
    as _i382;
import '../../../data/model/pagination/pagination_model.dart' as _i497;
import '../../../data/model/profile/email_identifier/email_identifier_model.dart'
    as _i721;
import '../../../data/model/profile/phone_identifier/phone_identifier_model.dart'
    as _i868;
import '../../../data/model/profile/profile/profile_model.dart' as _i228;
import '../../../data/repository/auth/auth_repository.dart' as _i728;
import '../../../data/repository/catalog/catalog_repository.dart' as _i601;
import '../../../data/repository/course_details/course_details_repository.dart'
    as _i783;
import '../../../data/repository/favorites/favorites_repository.dart' as _i433;
import '../../../data/repository/instructor/instructor_repository.dart'
    as _i1204;
import '../../../data/repository/notifications/notifications_repository.dart'
    as _i639;
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
    as _i734;
import '../../../domain/entity/catalog/get_courses_entity.dart' as _i1107;
import '../../../domain/entity/course_details/course_details_entity.dart'
    as _i707;
import '../../../domain/entity/favorites/favorites_entity.dart' as _i197;
import '../../../domain/entity/instructor/get_instructor_entity.dart' as _i1205;
import '../../../domain/entity/instructor/get_instructors_entity.dart' as _i1206;
import '../../../domain/entity/notifications/list_notifications_entity.dart'
    as _i964;
import '../../../domain/entity/notifications/notification_command_entity.dart'
    as _i149;
import '../../../domain/entity/notifications/update_notification_preferences_entity.dart'
    as _i568;
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
import '../../../domain/repository/catalog/i_catalog_repository.dart' as _i981;
import '../../../domain/repository/course_details/i_course_details_repository.dart'
    as _i971;
import '../../../domain/repository/favorites/i_favorites_repository.dart'
    as _i774;
import '../../../domain/repository/instructor/i_instructor_repository.dart'
    as _i1207;
import '../../../domain/repository/notifications/i_notifications_repository.dart'
    as _i919;
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
    as _i942;
import '../../../domain/usecase/catalog/get_courses_usecase.dart' as _i1108;
import '../../../domain/usecase/catalog/get_recommended_courses_usecase.dart'
    as _i205;
import '../../../domain/usecase/catalog/list_categories_usecase.dart' as _i193;
import '../../../domain/usecase/catalog/get_banners_usecase.dart' as _i1103;
import '../../../domain/usecase/catalog/get_course_filters_usecase.dart' as _i1104;
import '../../../domain/usecase/catalog/get_global_platforms_usecase.dart' as _i1105;
import '../../../domain/usecase/course_details/complete_lesson_usecase.dart'
    as _i665;
import '../../../domain/usecase/course_details/create_download_grant_usecase.dart'
    as _i976;
import '../../../domain/usecase/course_details/enroll_free_usecase.dart'
    as _i249;
import '../../../domain/usecase/course_details/get_access_status_usecase.dart'
    as _i421;
import '../../../domain/usecase/course_details/get_checkout_quote_usecase.dart'
    as _i878;
import '../../../domain/usecase/course_details/get_completion_usecase.dart'
    as _i116;
import '../../../domain/usecase/course_details/get_course_details_usecase.dart'
    as _i350;
import '../../../domain/usecase/course_details/get_curriculum_usecase.dart'
    as _i755;
import '../../../domain/usecase/course_details/get_enrollment_usecase.dart'
    as _i102;
import '../../../domain/usecase/course_details/get_learning_state_usecase.dart'
    as _i1033;
import '../../../domain/usecase/course_details/get_lesson_progress_usecase.dart'
    as _i736;
import '../../../domain/usecase/course_details/get_lesson_usecase.dart'
    as _i627;
import '../../../domain/usecase/course_details/get_rating_summary_usecase.dart'
    as _i756;
import '../../../domain/usecase/course_details/is_favorited_usecase.dart'
    as _i185;
import '../../../domain/usecase/course_details/list_resources_usecase.dart'
    as _i808;
import '../../../domain/usecase/course_details/list_reviews_usecase.dart'
    as _i216;
import '../../../domain/usecase/course_details/record_progress_usecase.dart'
    as _i629;
import '../../../domain/usecase/course_details/resolve_playback_usecase.dart'
    as _i707;
import '../../../domain/usecase/course_details/start_learning_usecase.dart'
    as _i198;
import '../../../domain/usecase/course_details/update_resume_usecase.dart'
    as _i828;
import '../../../domain/usecase/favorites/add_favorite_membership_usecase.dart'
    as _i531;
import '../../../domain/usecase/favorites/create_favorite_group_usecase.dart'
    as _i1024;
import '../../../domain/usecase/favorites/list_favorite_groups_usecase.dart'
    as _i974;
import '../../../domain/usecase/favorites/list_favorite_memberships_usecase.dart'
    as _i779;
import '../../../domain/usecase/instructor/get_instructor_usecase.dart' as _i1208;
import '../../../domain/usecase/instructor/get_instructors_usecase.dart'
    as _i1209;
import '../../../domain/usecase/i_use_case.dart' as _i759;
import '../../../domain/usecase/notifications/get_notification_preferences_usecase.dart'
    as _i440;
import '../../../domain/usecase/notifications/get_notification_usecase.dart'
    as _i78;
import '../../../domain/usecase/notifications/get_unread_notification_count_usecase.dart'
    as _i620;
import '../../../domain/usecase/notifications/list_notifications_usecase.dart'
    as _i423;
import '../../../domain/usecase/notifications/mark_all_notifications_read_usecase.dart'
    as _i276;
import '../../../domain/usecase/notifications/mark_notification_read_usecase.dart'
    as _i580;
import '../../../domain/usecase/notifications/update_notification_preferences_usecase.dart'
    as _i572;
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
    gh.factory<_i344.CatalogRemoteDataSource>(
      () => _i344.CatalogRemoteDataSource(),
    );
    gh.factory<_i647.CourseDetailsRemoteDataSource>(
      () => _i647.CourseDetailsRemoteDataSource(),
    );
    gh.factory<_i492.FavoritesRemoteDataSource>(
      () => _i492.FavoritesRemoteDataSource(),
    );
    gh.factory<_i1201.InstructorRemoteDataSource>(
      () => _i1201.InstructorRemoteDataSource(),
    );
    gh.factory<_i334.NotificationsRemoteDataSource>(
      () => _i334.NotificationsRemoteDataSource(),
    );
    gh.factory<_i265.ProfileRemoteDataSource>(
      () => _i265.ProfileRemoteDataSource(),
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.factory<_i971.ICourseDetailsRepository>(
      () => _i783.CourseDetailsRepository(
        gh<_i647.CourseDetailsRemoteDataSource>(),
      ),
    );
    gh.factory<_i981.ICatalogRepository>(
      () => _i601.CatalogRepository(gh<_i344.CatalogRemoteDataSource>()),
    );
    gh.factory<_i1207.IInstructorRepository>(
      () => _i1204.InstructorRepository(
        gh<_i1201.InstructorRemoteDataSource>(),
      ),
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i1202.InstructorModel>?,
        _i1206.GetInstructorsEntity
      >
    >(
      () => _i1209.GetInstructorsUsecase(
        gh<_i1207.IInstructorRepository>(),
      ),
      instanceName: 'GetInstructors',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i1202.InstructorModel>?,
        _i1205.GetInstructorEntity
      >
    >(
      () => _i1208.GetInstructorUsecase(
        gh<_i1207.IInstructorRepository>(),
      ),
      instanceName: 'GetInstructor',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.CoursesModel>?,
        _i734.GetFeaturedCoursesEntity
      >
    >(
      () => _i942.GetFeaturedCoursesUsecase(gh<_i981.ICatalogRepository>()),
      instanceName: 'GetFeaturedCourses',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.CoursesModel>?,
        _i1107.GetCoursesEntity
      >
    >(
      () => _i1108.GetCoursesUsecase(gh<_i981.ICatalogRepository>()),
      instanceName: 'GetCourses',
    );
    gh.factory<_i244.AuthStorageDataSource>(
      () => _i244.AuthStorageDataSource(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i874.RecommendationsModel>?, Null>
    >(
      () => _i205.GetRecommendedCoursesUsecase(gh<_i981.ICatalogRepository>()),
      instanceName: 'GetRecommendedCourses',
    );
    gh.factory<_i759.IUseCase<_i830.BaseModel<_i621.CategoriesModel>?, Null>>(
      () => _i193.ListCategoriesUsecase(gh<_i981.ICatalogRepository>()),
      instanceName: 'ListCategories',
    );
    gh.factory<_i759.IUseCase<_i830.BaseModel<_i1100.BannersModel>?, Null>>(
      () => _i1103.GetBannersUsecase(gh<_i981.ICatalogRepository>()),
      instanceName: 'GetBanners',
    );
    gh.factory<_i759.IUseCase<_i830.BaseModel<_i1101.CourseFiltersModel>?, Null>>(
      () => _i1104.GetCourseFiltersUsecase(gh<_i981.ICatalogRepository>()),
      instanceName: 'GetCourseFilters',
    );
    gh.factory<_i759.IUseCase<_i830.BaseModel<_i1102.GlobalPlatformsModel>?, Null>>(
      () => _i1105.GetGlobalPlatformsUsecase(gh<_i981.ICatalogRepository>()),
      instanceName: 'GetGlobalPlatforms',
    );
    gh.factory<_i919.INotificationsRepository>(
      () => _i639.NotificationsRepository(
        gh<_i334.NotificationsRemoteDataSource>(),
      ),
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i185.IsFavoritedUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'IsFavorited',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i116.GetCompletionUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetCompletion',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.CurriculumModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i755.GetCurriculumUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetCurriculum',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.CourseDetailsModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i350.GetCourseDetailsUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetCourseDetails',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i756.GetRatingSummaryUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetRatingSummary',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ResumePositionModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i828.UpdateResumeUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'UpdateResume',
    );
    gh.factory<_i774.IFavoritesRepository>(
      () => _i433.FavoritesRepository(gh<_i492.FavoritesRemoteDataSource>()),
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.EnrollmentModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i249.EnrollFreeUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'EnrollFree',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i878.GetCheckoutQuoteUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetCheckoutQuote',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.EnrollmentModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i102.GetEnrollmentUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetEnrollment',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ProgressEventModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i629.RecordProgressUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'RecordProgress',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i421.GetAccessStatusUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetAccessStatus',
    );
    gh.factory<_i950.IProfileRepository>(
      () => _i732.ProfileRepository(gh<_i265.ProfileRemoteDataSource>()),
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i228.ProfileModel>?,
        _i82.UploadAvatarEntity
      >
    >(
      () => _i911.UploadAvatarUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'UploadAvatar',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.PlaybackModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i707.ResolvePlaybackUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'ResolvePlayback',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.LearningStateModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () =>
          _i1033.GetLearningStateUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetLearningState',
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
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i216.ListReviewsUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'ListReviews',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i198.StartLearningUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'StartLearning',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () =>
          _i736.GetLessonProgressUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetLessonProgress',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.LessonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i627.GetLessonUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'GetLesson',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i808.ListResourcesUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'ListResources',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.ContractJsonModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i665.CompleteLessonUsecase(gh<_i971.ICourseDetailsRepository>()),
      instanceName: 'CompleteLesson',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i868.PhoneIdentifierModel>?,
        _i828.AddPhoneIdentifierEntity
      >
    >(
      () => _i469.AddPhoneIdentifierUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'AddPhoneIdentifier',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i102.DownloadGrantModel>?,
        _i707.CourseDetailsEntity
      >
    >(
      () => _i976.CreateDownloadGrantUsecase(
        gh<_i971.ICourseDetailsRepository>(),
      ),
      instanceName: 'CreateDownloadGrant',
    );
    gh.factory<_i154.IAuthRepository>(
      () => _i728.AuthRepository(
        gh<_i444.AuthRemoteDataSource>(),
        gh<_i244.AuthStorageDataSource>(),
      ),
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i758.NotificationModel>?,
        _i149.NotificationCommandEntity
      >
    >(
      () => _i78.GetNotificationUsecase(gh<_i919.INotificationsRepository>()),
      instanceName: 'GetNotification',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i341.NotificationPreferencesModel>?,
        _i568.UpdateNotificationPreferencesEntity
      >
    >(
      () => _i572.UpdateNotificationPreferencesUsecase(
        gh<_i919.INotificationsRepository>(),
      ),
      instanceName: 'UpdateNotificationPreferences',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i939.FavoriteMembershipsModel>?,
        _i197.FavoritesEntity
      >
    >(
      () => _i779.ListFavoriteMembershipsUsecase(
        gh<_i774.IFavoritesRepository>(),
      ),
      instanceName: 'ListFavoriteMemberships',
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i214.FavoriteGroupsModel>?, Null>
    >(
      () => _i974.ListFavoriteGroupsUsecase(gh<_i774.IFavoritesRepository>()),
      instanceName: 'ListFavoriteGroups',
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i382.UnreadNotificationCountModel>?, Null>
    >(
      () => _i620.GetUnreadNotificationCountUsecase(
        gh<_i919.INotificationsRepository>(),
      ),
      instanceName: 'GetUnreadNotificationCount',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i497.PaginationModel<_i758.NotificationModel>>?,
        _i964.ListNotificationsEntity
      >
    >(
      () =>
          _i423.ListNotificationsUsecase(gh<_i919.INotificationsRepository>()),
      instanceName: 'ListNotifications',
    );
    gh.factory<_i759.IUseCase<_i830.BaseModel<Object>?, Null>>(
      () => _i276.MarkAllNotificationsReadUsecase(
        gh<_i919.INotificationsRepository>(),
      ),
      instanceName: 'MarkAllNotificationsRead',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i388.FavoriteGroupModel>?,
        _i197.FavoritesEntity
      >
    >(
      () => _i1024.CreateFavoriteGroupUsecase(gh<_i774.IFavoritesRepository>()),
      instanceName: 'CreateFavoriteGroup',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i955.FavoriteMembershipModel>?,
        _i197.FavoritesEntity
      >
    >(
      () =>
          _i531.AddFavoriteMembershipUsecase(gh<_i774.IFavoritesRepository>()),
      instanceName: 'AddFavoriteMembership',
    );
    gh.factory<
      _i759.IUseCase<_i830.BaseModel<_i341.NotificationPreferencesModel>?, Null>
    >(
      () => _i440.GetNotificationPreferencesUsecase(
        gh<_i919.INotificationsRepository>(),
      ),
      instanceName: 'GetNotificationPreferences',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i758.NotificationModel>?,
        _i149.NotificationCommandEntity
      >
    >(
      () => _i580.MarkNotificationReadUsecase(
        gh<_i919.INotificationsRepository>(),
      ),
      instanceName: 'MarkNotificationRead',
    );
    gh.factory<
      _i759.IUseCase<
        _i830.BaseModel<_i868.PhoneIdentifierModel>?,
        _i212.ChangePhoneEntity
      >
    >(
      () => _i230.ChangePhoneUsecase(gh<_i950.IProfileRepository>()),
      instanceName: 'ChangePhone',
    );
    gh.factory<_i759.IUseCase<_i830.BaseModel<_i228.ProfileModel>?, Null>>(
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
        _i830.BaseModel<_i721.EmailIdentifierModel>?,
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
        _i830.BaseModel<_i228.ProfileModel>?,
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
        _i830.BaseModel<_i228.ProfileModel>?,
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
        _i830.BaseModel<_i721.EmailIdentifierModel>?,
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
