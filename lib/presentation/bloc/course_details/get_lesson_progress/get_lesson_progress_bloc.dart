import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wlcd/core/services/locator/locator.dart';
import 'package:wlcd/data/model/base/base_model.dart';
import 'package:wlcd/data/model/course_details/course_details_model.dart';
import 'package:wlcd/domain/entity/course_details/course_details_entity.dart';
import 'package:wlcd/domain/usecase/i_use_case.dart';

part 'get_lesson_progress_event.dart';
part 'get_lesson_progress_state.dart';

class GetLessonProgressBloc extends Bloc<IGetLessonProgressEvent, IGetLessonProgressState> {
  GetLessonProgressBloc() : super(const GetLessonProgressInitial()) {
    on<LoadGetLessonProgressEvent>(_load);
  }

  FutureOr<void> _load(
    LoadGetLessonProgressEvent event,
    Emitter<IGetLessonProgressState> emit,
  ) async {
    emit(const GetLessonProgressLoading());
    try {
      final usecase = locator<IUseCase<BaseModel<ContractJsonModel>?, CourseDetailsEntity>>(
        instanceName: 'GetLessonProgress',
      );
      final response = await usecase(event.entity);
      response.fold(
        (failure) => emit(GetLessonProgressFailed(failure.message)),
        (value) => emit(GetLessonProgressLoaded(value?.data)),
      );
    } catch (error, stackTrace) {
      log(error.toString());
      log(stackTrace.toString());
      emit(GetLessonProgressFailed(error.toString()));
    }
  }
}
