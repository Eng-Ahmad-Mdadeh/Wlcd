import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/email_identifier/email_identifier_model.dart';
import 'package:wlcd/data/model/profile/profile/profile_model.dart';
import 'package:wlcd/data/model/profile/phone_identifier/phone_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/add_email_identifier_entity.dart';
import 'package:wlcd/domain/entity/profile/add_phone_identifier_entity.dart';
import 'package:wlcd/domain/entity/profile/change_email_entity.dart';
import 'package:wlcd/domain/entity/profile/change_phone_entity.dart';
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
    isFormDate: false,
    wrappedResponse: false,
    fromJsonT: _profileFromJson,
  );

  Future<Either<AppException, BaseModel<ProfileModel>?>> updateProfile(UpdateProfileEntity intent) => patchData(
    endpoint: ApiEndpoints.updateProfile,
    data: intent.toJson(),
    isFormData: false,
    wrappedResponse: false,
    fromJsonT: _profileFromJson,
  );

  Future<Either<AppException, BaseModel<ProfileModel>?>> uploadAvatar(UploadAvatarEntity intent) => postData(
    endpoint: ApiEndpoints.learnerAvatar,
    files: intent.file ?? const [],
    isFormDate: true,
    wrappedResponse: false,
    fromJsonT: _profileFromJson,
  );

  Future<Either<AppException, BaseModel<EmailIdentifierModel>?>>
  addEmailIdentifier(
    AddEmailIdentifierEntity intent,
  ) => postDataAs<EmailIdentifierModel>(
    endpoint: ApiEndpoints.addEmailIdentifier,
    data: intent.toJson(),
    isFormDate: false,
    wrappedResponse: false,
    fromJsonT: _emailIdentifierFromJson,
  );

  Future<Either<AppException, BaseModel<EmailIdentifierModel>?>> changeEmail(
    ChangeEmailEntity intent,
  ) => postDataAs<EmailIdentifierModel>(
    endpoint: ApiEndpoints.changeEmail,
    data: intent.toJson(),
    isFormDate: false,
    wrappedResponse: false,
    fromJsonT: _emailIdentifierFromJson,
  );

  Future<Either<AppException, BaseModel<PhoneIdentifierModel>?>>
  addPhoneIdentifier(
    AddPhoneIdentifierEntity intent,
  ) => postDataAs<PhoneIdentifierModel>(
    endpoint: ApiEndpoints.addPhoneIdentifier,
    data: intent.toJson(),
    isFormDate: false,
    wrappedResponse: false,
    fromJsonT: _phoneIdentifierFromJson,
  );

  Future<Either<AppException, BaseModel<PhoneIdentifierModel>?>> changePhone(
    ChangePhoneEntity intent,
  ) => postDataAs<PhoneIdentifierModel>(
    endpoint: ApiEndpoints.changePhone,
    data: intent.toJson(),
    isFormDate: false,
    wrappedResponse: false,
    fromJsonT: _phoneIdentifierFromJson,
  );

  static ProfileModel _profileFromJson(Object? json) => ProfileModel.fromJson(json as Map<String, dynamic>);

  static EmailIdentifierModel _emailIdentifierFromJson(Object? json) =>
      EmailIdentifierModel.fromJson(json as Map<String, dynamic>);

  static PhoneIdentifierModel _phoneIdentifierFromJson(Object? json) =>
      PhoneIdentifierModel.fromJson(json as Map<String, dynamic>);
}
