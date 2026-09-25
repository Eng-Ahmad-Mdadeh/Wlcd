import 'package:dartz/dartz.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/booking/available_slots_model.dart';
import 'package:wlcd/domain/entity/booking/get_available_slots_entity.dart';

abstract interface class IBookingRepository {
  Future<Either<AppException, BaseModel<AvailableSlotsModel>?>>
  getAvailableSlots(GetAvailableSlotsEntity entity);
}
