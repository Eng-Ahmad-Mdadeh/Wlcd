import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/auth/session_model.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/domain/repository/auth/i_auth_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<SessionModel>?, Null>)
@Named('GetSession')
class GetSessionUsecase implements IUseCase<BaseModel<SessionModel>?, Null> {
  const GetSessionUsecase(this._repository);

  final IAuthRepository _repository;

  @override
  Future<Either<AppException, BaseModel<SessionModel>?>> call(Null data) {
    return _repository.getSession();
  }
}
