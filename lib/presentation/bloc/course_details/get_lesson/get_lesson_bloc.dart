import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_lesson_event.dart';
part 'get_lesson_state.dart';

class GetLessonBloc extends Bloc<IGetLessonEvent, IGetLessonState> {
  GetLessonBloc() : super(const GetLessonInitial()) {
    on<LoadGetLessonEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetLessonEvent event,
    Emitter<IGetLessonState> emit,
  ) async {
    emit(const GetLessonLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<LessonModel>?, CourseDetailsEntity>>(
        instanceName: 'GetLesson',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetLessonFailed(failure.message)),
        (value) => emit(GetLessonLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetLessonFailed(error.toString()));
    }
  }
}
