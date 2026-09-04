import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/catalog/course/courses_model.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'recommended_courses_event.dart';
part 'recommended_courses_state.dart';

class RecommendedCoursesBloc
    extends Bloc<IRecommendedCoursesEvent, IRecommendedCoursesState> {
  RecommendedCoursesBloc() : super(const RecommendedCoursesInitial()) {
    on<LoadRecommendedCoursesEvent>(_load);
  }

  FutureOr<void> _load(
    LoadRecommendedCoursesEvent event,
    Emitter<IRecommendedCoursesState> emit,
  ) async {
    emit(const RecommendedCoursesLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<CoursesModel>?, Null>>(
        instanceName: 'GetRecommendedCourses',
      );
      final response = await usecase(null);
      response.fold(
        (failure) => emit(RecommendedCoursesFailed(failure.message)),
        (value) => emit(RecommendedCoursesLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(RecommendedCoursesFailed(error.toString()));
    }
  }
}
