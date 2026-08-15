import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/profile/phone_identifier_model.dart';
import 'package:wlcd/domain/entity/profile/change_phone_entity.dart';
import 'package:wlcd/domain/repository/profile/i_profile_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(as: IUseCase<BaseModel<PhoneIdentifierModel>?, ChangePhoneEntity>)
@Named('ChangePhone')
class ChangePhoneUsecase
    implements IUseCase<BaseModel<PhoneIdentifierModel>?, ChangePhoneEntity> {
  const ChangePhoneUsecase(this._repository);

  final IProfileRepository _repository;

  @override
  Future<Either<AppException, BaseModel<PhoneIdentifierModel>?>> call(
    ChangePhoneEntity data,
  ) => _repository.changePhone(data);
}
