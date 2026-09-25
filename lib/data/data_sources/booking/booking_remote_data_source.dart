import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:wlcd/core/constants/api_endpoints.dart';
import 'package:wlcd/core/exceptions/app_exception.dart';
import 'package:wlcd/data/data_sources/base/base_remote_data_source.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/booking/available_slots_model.dart';
import 'package:wlcd/domain/entity/booking/get_available_slots_entity.dart';

@injectable
class BookingRemoteDataSource extends BaseRemoteDataSource<Object> {
  BookingRemoteDataSource() : super('');

  Future<Either<AppException, BaseModel<AvailableSlotsModel>?>>
  getAvailableSlots(GetAvailableSlotsEntity entity) =>
      fetchDataAs<AvailableSlotsModel>(
        endpoint: ApiEndpoints.availableSlots(entity.instructorId),
        queryParams: entity.toQueryParameters(),
        fromJsonT: (json) =>
            AvailableSlotsModel.fromJson(json as Map<String, dynamic>),
        wrappedResponse: false,
      );
}
