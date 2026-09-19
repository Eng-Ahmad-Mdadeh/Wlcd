import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/repository/course_details/i_course_details_repository.dart';
import 'package:wlcd/domain/usecase/course_details/course_details_usecase.dart';

part 'course_details_event.dart';
part 'course_details_state.dart';

class CourseDetailsBloc extends Bloc<ICourseDetailsEvent, ICourseDetailsState> {
  CourseDetailsBloc() : super(const CourseDetailsInitial()) {
    on<LoadCourseDetailsEvent>(_load);
  }

  FutureOr<void> _load(LoadCourseDetailsEvent event,
      Emitter<ICourseDetailsState> emit) async {
    emit(CourseDetailsLoading(event.operation));
    try {
      final result = await locator<CourseDetailsUsecase>()<Object>(event.operation, event.entity);
      result.fold(
        (failure) => emit(CourseDetailsFailed(event.operation, failure.message)),
        (response) => emit(CourseDetailsLoaded(event.operation, response?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString(), stackTrace: stackTrace);
      emit(CourseDetailsFailed(event.operation, error.toString()));
    }
  }
}
