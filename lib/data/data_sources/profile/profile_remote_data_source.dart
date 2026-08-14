import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/domain/entity/profile/complete_profile_entity.dart';
import 'package:wlcd/domain/entity/profile/update_profile_entity.dart';
import 'package:wlcd/domain/entity/profile/upload_avatar_entity.dart';

@injectable
class ProfileRemoteDataSource extends BaseRemoteDataSource<ProfileModel> {
  ProfileRemoteDataSource() : super(ApiEndpoints.accounts);

  Future<Either<AppException, BaseModel<ProfileModel>?>> getProfile() =>
      fetchData(endpoint: ApiEndpoints.profile, fromJsonT: _profileFromJson, wrappedResponse: false);

  Future<Either<AppException, BaseModel<ProfileModel>?>> completeProfile(CompleteProfileEntity intent) => postData(
    endpoint: ApiEndpoints.completeProfile,
    data: intent.toJson(),
    headers: intent.headers,
    isFormDate: false,
    wrappedResponse: false,
    fromJsonT: _profileFromJson,
  );

  Future<Either<AppException, BaseModel<ProfileModel>?>> updateProfile(UpdateProfileEntity intent) => patchData(
    endpoint: ApiEndpoints.updateProfile,
    data: intent.toJson(),
    headers: intent.headers,
    isFormData: false,
    wrappedResponse: false,
    fromJsonT: _profileFromJson,
  );

  Future<Either<AppException, BaseModel<ProfileModel>?>> uploadAvatar(UploadAvatarEntity intent) => postData(
    endpoint: ApiEndpoints.learnerAvatar,
    headers: intent.headers,
    files: [
      {'field_name': 'file', 'path': intent.filePath},
    ],
    isFormDate: true,
    wrappedResponse: false,
    fromJsonT: _profileFromJson,
  );

  static ProfileModel _profileFromJson(Object? json) => ProfileModel.fromJson(json as Map<String, dynamic>);
}
