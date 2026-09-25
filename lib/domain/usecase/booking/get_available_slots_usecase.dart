import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/booking/available_slots_model.dart';
import 'package:wlcd/domain/entity/booking/get_available_slots_entity.dart';
import 'package:wlcd/domain/repository/booking/i_booking_repository.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

@Injectable(
  as: IUseCase<BaseModel<AvailableSlotsModel>?, GetAvailableSlotsEntity>,
)
@Named('GetAvailableSlots')
class GetAvailableSlotsUsecase
    implements
        IUseCase<BaseModel<AvailableSlotsModel>?, GetAvailableSlotsEntity> {
  const GetAvailableSlotsUsecase(this._repository);

  final IBookingRepository _repository;

  @override
  Future<Either<AppException, BaseModel<AvailableSlotsModel>?>> call(
    GetAvailableSlotsEntity data,
  ) => _repository.getAvailableSlots(data);
}
