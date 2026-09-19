import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_enrollment_event.dart';
part 'get_enrollment_state.dart';

class GetEnrollmentBloc extends Bloc<IGetEnrollmentEvent, IGetEnrollmentState> {
  GetEnrollmentBloc() : super(const GetEnrollmentInitial()) {
    on<LoadGetEnrollmentEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetEnrollmentEvent event,
    Emitter<IGetEnrollmentState> emit,
  ) async {
    emit(const GetEnrollmentLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<EnrollmentModel>?, CourseDetailsEntity>>(
        instanceName: 'GetEnrollment',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetEnrollmentFailed(failure.message)),
        (value) => emit(GetEnrollmentLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetEnrollmentFailed(error.toString()));
    }
  }
}
