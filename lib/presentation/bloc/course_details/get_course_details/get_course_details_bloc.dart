import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_course_details_event.dart';
part 'get_course_details_state.dart';

class GetCourseDetailsBloc extends Bloc<IGetCourseDetailsEvent, IGetCourseDetailsState> {
  GetCourseDetailsBloc() : super(const GetCourseDetailsInitial()) {
    on<LoadGetCourseDetailsEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetCourseDetailsEvent event,
    Emitter<IGetCourseDetailsState> emit,
  ) async {
    emit(const GetCourseDetailsLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<CourseDetailsModel>?, CourseDetailsEntity>>(
        instanceName: 'GetCourseDetails',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetCourseDetailsFailed(failure.message)),
        (value) => emit(GetCourseDetailsLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetCourseDetailsFailed(error.toString()));
    }
  }
}
