import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/auth/verify_email_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';
import 'package:wlcd/domain/entity/auth/register_with_phone_entity.dart';
import 'package:wlcd/domain/entity/auth/verify_email_entity.dart';

abstract interface class IAuthRepository {
  Future<Either<AppException, BaseModel<AuthModel>?>> registerWithEmail(
    RegisterWithEmailEntity data,
  );

  Future<Either<AppException, BaseModel<AuthModel>?>> registerWithPhone(
    RegisterWithPhoneEntity data,
  );

  Future<Either<AppException, BaseModel<VerifyEmailModel>?>> verifyEmail(
    VerifyEmailEntity data,
  );
}
