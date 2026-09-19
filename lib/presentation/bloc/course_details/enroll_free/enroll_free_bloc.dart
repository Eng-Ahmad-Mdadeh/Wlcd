import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'enroll_free_event.dart';
part 'enroll_free_state.dart';

class EnrollFreeBloc extends Bloc<IEnrollFreeEvent, IEnrollFreeState> {
  EnrollFreeBloc() : super(const EnrollFreeInitial()) {
    on<LoadEnrollFreeEvent>(_load);
  }

  FutureOr<void> _load(
    LoadEnrollFreeEvent event,
    Emitter<IEnrollFreeState> emit,
  ) async {
    emit(const EnrollFreeLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<EnrollmentModel>?, CourseDetailsEntity>>(
        instanceName: 'EnrollFree',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(EnrollFreeFailed(failure.message)),
        (value) => emit(EnrollFreeLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(EnrollFreeFailed(error.toString()));
    }
  }
}
