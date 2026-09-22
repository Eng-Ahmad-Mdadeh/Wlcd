import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/courses/courses_model.dart';
import 'package:wlcd/domain/entity/catalog/get_courses_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'courses_event.dart';
part 'courses_state.dart';

class CoursesBloc extends Bloc<ICoursesEvent, ICoursesState> {
  CoursesBloc() : super(const CoursesInitial()) {
    on<LoadCoursesEvent>(_load);
  }

  FutureOr<void> _load(
    LoadCoursesEvent event,
    Emitter<ICoursesState> emit,
  ) async {
    emit(const CoursesLoading());
    try {
      final usecase = locator<
        IUseCase<BaseModel<CoursesModel>?, GetCoursesEntity>
      >(instanceName: 'GetCourses');
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(CoursesFailed(failure.message)),
        (value) => emit(CoursesLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(CoursesFailed(error.toString()));
    }
  }
}
