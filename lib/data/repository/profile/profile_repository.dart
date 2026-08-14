import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/profile/profile_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/complete_profile_entity.dart';
import 'package:wlcd/domain/entity/profile/update_profile_entity.dart';
import 'package:wlcd/domain/entity/profile/upload_avatar_entity.dart';
import 'package:wlcd/domain/repository/profile/i_profile_repository.dart';

@Injectable(as: IProfileRepository)
class ProfileRepository implements IProfileRepository {
  const ProfileRepository(this._remoteDataSource);

  final ProfileRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<ProfileModel>?>> getProfile() =>
      _remoteDataSource.getProfile();

  @override
  Future<Either<AppException, BaseModel<ProfileModel>?>> completeProfile(
    CompleteProfileEntity intent,
  ) => _remoteDataSource.completeProfile(intent);

  @override
  Future<Either<AppException, BaseModel<ProfileModel>?>> updateProfile(
    UpdateProfileEntity intent,
  ) => _remoteDataSource.updateProfile(intent);

  @override
  Future<Either<AppException, BaseModel<ProfileModel>?>> uploadAvatar(
    UploadAvatarEntity intent,
  ) => _remoteDataSource.uploadAvatar(intent);
}
