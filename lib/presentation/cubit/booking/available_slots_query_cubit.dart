import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/domain/entity/booking/get_available_slots_entity.dart';

class AvailableSlotsQueryCubit extends Cubit<GetAvailableSlotsEntity> {
  AvailableSlotsQueryCubit({required String instructorId})
    : super(GetAvailableSlotsEntity(instructorId: instructorId));

  void setDateRange({String? from, String? to}) => emit(
    state.copyWith(
      from: from,
      to: to,
      clearFrom: from == null || from.isEmpty,
      clearTo: to == null || to.isEmpty,
    ),
  );

  void setTimeZone(String? timeZone) => emit(
    state.copyWith(
      timeZone: timeZone,
      clearTimeZone: timeZone == null || timeZone.isEmpty,
    ),
  );

  void reset() => emit(
    GetAvailableSlotsEntity(instructorId: state.instructorId),
  );
}
