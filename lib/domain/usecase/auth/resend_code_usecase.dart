// import 'package:tamalok/domain/entity/auth/auth_entity.dart';
// import 'package:tamalok/domain/repository/auth/i_auth_repository.dart';
// import 'package:tamalok/domain/usecase/i_use_case.dart';
// import 'package:dartz/dartz.dart';
// import 'package:injectable/injectable.dart';
// import 'package:tamalok/data/model/auth/auth_model.dart';
// import 'package:tamalok/data/model/base/base_model.dart';
//
//
// import '../../../core/exceptions/app_exception.dart';
//
// @Injectable(as: IUseCase<BaseModel<AuthModel>?, AuthEntity>)
// @Named('ResendCode')
// class ResendCodeUsecase implements IUseCase<BaseModel<AuthModel>?, AuthEntity> {
//   final IAuthRepository _repository;
//
//   ResendCodeUsecase(this._repository);
//
//   @override
//   Future<Either<AppException, BaseModel<AuthModel>?>> call(AuthEntity data) {
//     return _repository.login(data);
//   }
// }
