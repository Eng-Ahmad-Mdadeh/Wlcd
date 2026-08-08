import 'package:wlcd/domain/entity/auth/auth_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/auth/auth_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/entity/auth/register_with_email_entity.dart';

@Injectable()
class AuthRemoteDataSource extends BaseRemoteDataSource<AuthModel> {
  AuthRemoteDataSource() : super(ApiEndpoints.auth);

  Future<Either<AppException, BaseModel<AuthModel>?>> registerWithEmail(
    RegisterWithEmailEntity data,
  ) {
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
