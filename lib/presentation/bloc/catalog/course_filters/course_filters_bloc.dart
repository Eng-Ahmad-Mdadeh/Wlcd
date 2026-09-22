import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/course_filters/course_filters_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'course_filters_event.dart';
part 'course_filters_state.dart';

class CourseFiltersBloc extends Bloc<ICourseFiltersEvent, ICourseFiltersState> {
  CourseFiltersBloc() : super(const CourseFiltersInitial()) {
    on<LoadCourseFiltersEvent>(_load);
  }

  FutureOr<void> _load(
    LoadCourseFiltersEvent event,
    Emitter<ICourseFiltersState> emit,
  ) async {
    emit(const CourseFiltersLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<CourseFiltersModel>?, Null>>(
        instanceName: 'GetCourseFilters',
      );
      final response = await usecase(null);
      response.fold(
        (failure) => emit(CourseFiltersFailed(failure.message)),
        (value) => emit(CourseFiltersLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(CourseFiltersFailed(error.toString()));
    }
  }
}
