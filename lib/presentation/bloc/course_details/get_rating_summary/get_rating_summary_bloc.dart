import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_rating_summary_event.dart';
part 'get_rating_summary_state.dart';

class GetRatingSummaryBloc extends Bloc<IGetRatingSummaryEvent, IGetRatingSummaryState> {
  GetRatingSummaryBloc() : super(const GetRatingSummaryInitial()) {
    on<LoadGetRatingSummaryEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetRatingSummaryEvent event,
    Emitter<IGetRatingSummaryState> emit,
  ) async {
    emit(const GetRatingSummaryLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'GetRatingSummary',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetRatingSummaryFailed(failure.message)),
        (value) => emit(GetRatingSummaryLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetRatingSummaryFailed(error.toString()));
    }
  }
}
