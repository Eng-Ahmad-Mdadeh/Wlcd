import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/email_identifier/email_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/change_email_entity.dart';
import 'package:wlcd/domain/repository/profile/i_profile_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<EmailIdentifierModel>?, ChangeEmailEntity>)
@Named('ChangeEmail')
class ChangeEmailUsecase
    implements IUseCase<BaseModel<EmailIdentifierModel>?, ChangeEmailEntity> {
  const ChangeEmailUsecase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<AppException, BaseModel<EmailIdentifierModel>?>> call(
    ChangeEmailEntity data,
  ) => _repository.changeEmail(data);
}
