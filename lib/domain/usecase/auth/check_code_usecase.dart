// import 'package:tamalok/domain/entity/auth/auth_entity.dart';
// import 'package:tamalok/domain/repository/auth/i_auth_repository.dart';
// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:tamalok/data/model/auth/auth_model.dart';
// import 'package:tamalok/data/model/base/base_model.dart';
// import 'package:tamalok/domain/usecase/i_use_case.dart';
//
// import '../../../core/exceptions/app_exception.dart';
//
// @Injectable(as: IUseCase<BaseModel<AuthModel>?, AuthEntity>)
// @Named('CheckCode')
// class CheckCodeUsecase implements IUseCase<BaseModel<AuthModel>?, AuthEntity> {
//   final IAuthRepository _repository;
//
//   CheckCodeUsecase(this._repository);
//
//   @override
//   Future<Either<AppException, BaseModel<AuthModel>?>> call(AuthEntity data) {
//     return _repository.checkCode(data);
//   }
// }
