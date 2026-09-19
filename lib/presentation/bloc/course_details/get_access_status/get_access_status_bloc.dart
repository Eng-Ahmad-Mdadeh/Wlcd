import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_access_status_event.dart';
part 'get_access_status_state.dart';

class GetAccessStatusBloc extends Bloc<IGetAccessStatusEvent, IGetAccessStatusState> {
  GetAccessStatusBloc() : super(const GetAccessStatusInitial()) {
    on<LoadGetAccessStatusEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetAccessStatusEvent event,
    Emitter<IGetAccessStatusState> emit,
  ) async {
    emit(const GetAccessStatusLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'GetAccessStatus',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetAccessStatusFailed(failure.message)),
        (value) => emit(GetAccessStatusLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetAccessStatusFailed(error.toString()));
    }
  }
}
