import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/booking/available_slots_model.dart';
import 'package:wlcd/domain/entity/booking/get_available_slots_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'available_slots_event.dart';
part 'available_slots_state.dart';

class AvailableSlotsBloc
    extends Bloc<IAvailableSlotsEvent, IAvailableSlotsState> {
  AvailableSlotsBloc() : super(const AvailableSlotsInitial()) {
    on<LoadAvailableSlotsEvent>(_load);
  }

  FutureOr<void> _load(
    LoadAvailableSlotsEvent event,
    Emitter<IAvailableSlotsState> emit,
  ) async {
    emit(const AvailableSlotsLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<AvailableSlotsModel>?, GetAvailableSlotsEntity>
      >(instanceName: 'GetAvailableSlots');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(AvailableSlotsFailed(failure.message)),
        (value) => emit(AvailableSlotsLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(AvailableSlotsFailed(error.toString()));
    }
  }
}
