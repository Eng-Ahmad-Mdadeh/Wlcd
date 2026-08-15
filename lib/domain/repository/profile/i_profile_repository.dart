import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/email_identifier_model.dart';
import 'package:wlcd/data/model/profile/profile_model.dart';
import 'package:wlcd/data/model/profile/phone_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/add_email_identifier_entity.dart';
import 'package:wlcd/domain/entity/profile/add_phone_identifier_entity.dart';
import 'package:wlcd/domain/entity/profile/change_email_entity.dart';
import 'package:wlcd/domain/entity/profile/change_phone_entity.dart';
import 'package:wlcd/domain/entity/profile/complete_profile_entity.dart';
import 'package:wlcd/domain/entity/profile/update_profile_entity.dart';
import 'package:wlcd/domain/entity/profile/upload_avatar_entity.dart';

abstract interface class IProfileRepository {
  Future<Either<AppException, BaseModel<ProfileModel>?>> getProfile();

  Future<Either<AppException, BaseModel<ProfileModel>?>> completeProfile(
    CompleteProfileEntity intent,
  );

  Future<Either<AppException, BaseModel<ProfileModel>?>> updateProfile(
    UpdateProfileEntity intent,
  );

  Future<Either<AppException, BaseModel<ProfileModel>?>> uploadAvatar(
    UploadAvatarEntity intent,
  );

  Future<Either<AppException, BaseModel<EmailIdentifierModel>?>>
  addEmailIdentifier(AddEmailIdentifierEntity intent);

  Future<Either<AppException, BaseModel<EmailIdentifierModel>?>> changeEmail(
    ChangeEmailEntity intent,
  );

  Future<Either<AppException, BaseModel<PhoneIdentifierModel>?>>
  addPhoneIdentifier(AddPhoneIdentifierEntity intent);

  Future<Either<AppException, BaseModel<PhoneIdentifierModel>?>> changePhone(
    ChangePhoneEntity intent,
  );
}
