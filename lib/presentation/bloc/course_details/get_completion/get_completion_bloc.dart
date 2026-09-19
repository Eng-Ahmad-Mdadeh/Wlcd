import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_completion_event.dart';
part 'get_completion_state.dart';

class GetCompletionBloc extends Bloc<IGetCompletionEvent, IGetCompletionState> {
  GetCompletionBloc() : super(const GetCompletionInitial()) {
    on<LoadGetCompletionEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetCompletionEvent event,
    Emitter<IGetCompletionState> emit,
  ) async {
    emit(const GetCompletionLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'GetCompletion',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetCompletionFailed(failure.message)),
        (value) => emit(GetCompletionLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetCompletionFailed(error.toString()));
    }
  }
}
