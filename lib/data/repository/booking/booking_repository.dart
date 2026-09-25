import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/booking/booking_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/booking/available_slots_model.dart';
import 'package:wlcd/domain/entity/booking/get_available_slots_entity.dart';
import 'package:wlcd/domain/repository/booking/i_booking_repository.dart';

@Injectable(as: IBookingRepository)
class BookingRepository implements IBookingRepository {
  const BookingRepository(this._remoteDataSource);

  final BookingRemoteDataSource _remoteDataSource;

  @override
  Future<Either<AppException, BaseModel<AvailableSlotsModel>?>>
  getAvailableSlots(GetAvailableSlotsEntity entity) =>
      _remoteDataSource.getAvailableSlots(entity);
}
